// 🛠️ Fix: utilise `contains` pour les vérifications de connexion WiFi/mobile.
// Provider utilisateur pour AniSphère.
// Gère l’état utilisateur, les connexions (email, Google, Apple),
// la synchronisation Firebase/Hive et les notifications UI.
// Copilot Prompt : "UserProvider gère l’utilisateur, la connexion, et déclenche la synchro IA cloud si premium"


import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';
import '../services/auth_service.dart';
import 'package:anisphere/modules/noyau/logic/ia_master.dart'; // 👈 IA ajoutée

class UserProvider with ChangeNotifier {
  final UserService _userService;
  final AuthService _authService;

  UserModel? _user;
  UserModel? get user => _user;

  UserProvider(this._userService, this._authService);

  /// Met à jour l'utilisateur actuel et notifie les listeners.
  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  /// 📦 Chargement local ou distant
  Future<void> loadUser() async {
    try {
      await _userService.init(); // Init Hive
      final currentUser = _authService.currentUser;

      if (currentUser != null) {
        _user = await _fetchUser(currentUser.uid);
        debugPrint('[loadUser] Chargement utilisateur depuis Hive : $_user');
        _logAndNotifyUserState(_user, "chargé");
        if (_user == null) {
          notifyListeners();
        }

        // ✅ Synchronisation IA si premium
        if (_user?.iaPremium == true) {
          await IAMaster.instance.syncCloudIA(_user!.id);
        }
      } else {
        debugPrint("⚠️ Aucun utilisateur connecté.");
        notifyListeners();
      }
    } catch (e) {
      _logError("loadUser", e);
    }
  }

  /// 🔁 Mise à jour globale
  Future<void> updateUser(UserModel user) async {
    try {
      await _userService.updateUser(user);
      _user = user;
      notifyListeners();
      debugPrint("✅ Utilisateur mis à jour : ${user.email}");

      // ✅ Synchronisation IA si premium
      if (user.iaPremium) {
        await IAMaster.instance.syncCloudIA(user.id);
      }
    } catch (e) {
      _logError("updateUser", e);
    }
  }

  /// 🔐 Connexion par email
  Future<bool> signInWithEmail(String email, String password) async {
    return await _signIn(
        () => _authService.signInWithEmail(email, password), "email");
  }

  /// 🆕 Inscription
  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String profession,
  }) async {
    return await _signIn(
      () => _authService.signUpWithEmail(
        name: name,
        email: email,
        password: password,
        phone: phone,
        profession: profession,
      ),
      "inscription",
    );
  }

  /// 🔐 Connexion Google
  Future<bool> signInWithGoogle() async {
    return await _signIn(() => _authService.signInWithGoogle(), "Google");
  }

  /// 🍏 Connexion Apple
  Future<bool> signInWithApple() async {
    return await _signIn(() => _authService.signInWithApple(), "Apple");
  }

  /// 🔓 Déconnexion
  Future<void> signOut() async {
    try {
      await _userService.init(); // Hive ready
      if (_user != null) {
        await _userService.deleteUserLocally();
      }

      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity.contains(ConnectivityResult.wifi) ||
          connectivity.contains(ConnectivityResult.mobile)) {
        await _authService.signOut();
        debugPrint("✅ Déconnexion Firebase !");
      } else {
        debugPrint("⚠️ Déconnexion locale (pas de réseau).");
      }

      _user = null;
      notifyListeners();
      debugPrint("✅ Déconnexion réussie !");
    } catch (e) {
      _logError("signOut", e);
    }
  }

  /// Méthode privée pour récupérer un utilisateur
  Future<UserModel?> _fetchUser(String uid) async {
    return _userService.getUserFromHive() ??
        await _userService.getUserFromFirebase(uid);
  }

  /// Méthode privée pour gérer les connexions
  Future<bool> _signIn(
      Future<UserModel?> Function() signInMethod, String method) async {
    try {
      final user = await signInMethod();
      if (user != null) {
        _user = user;
        notifyListeners();
        debugPrint("✅ Connexion $method : ${user.email}");

        // ✅ Synchronisation IA si premium
        if (user.iaPremium) {
          await IAMaster.instance.syncCloudIA(user.id);
        }

        return true;
      }
    } catch (e) {
      _logError("Connexion $method", e);
    }
    return false;
  }

  /// Méthode privée pour logguer et notifier l'état utilisateur
  void _logAndNotifyUserState(UserModel? user, String action) {
    if (user != null) {
      assert(() {
        debugPrint("✅ Utilisateur $action : ${user.email}");
        return true;
      }());
      notifyListeners();
    } else {
      assert(() {
        debugPrint("⚠️ Aucun utilisateur trouvé.");
        return true;
      }());
    }
  }

  /// Méthode privée pour logguer les erreurs
  void _logError(String context, Object error) {
    assert(() {
      debugPrint("❌ Erreur $context : $error");
      return true;
    }());
  }

  /// 🔍 Accès au service utilisateur (ex: pour IAContextProvider)
  UserService get userService => _userService;

  /// 🔐 Accès au service d'authentification
  AuthService get authService => _authService;
}
