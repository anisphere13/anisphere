import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; 
import 'package:anisphere/models/user_model.dart';
import 'package:anisphere/services/user_service.dart';
import 'package:anisphere/services/auth_service.dart';
import 'package:anisphere/services/firebase_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService;
  final AuthService _authService;
  UserModel? _user;

  UserProvider(this._userService, this._authService);

  UserModel? get user => _user;

  /// 🔄 **Chargement de l'utilisateur depuis Firebase ou Hive**
  Future<void> loadUser() async {
    try {
      await _userService.initHive(); // ✅ Initialiser Hive avant d'accéder aux données locales

      final currentUser = _authService.currentUser;
      if (currentUser != null) {
        _user = _userService.getUserFromHive() ??
            await _userService.getUserFromFirebase(currentUser.uid);
        
        if (_user != null) {
          debugPrint("✅ Utilisateur chargé : ${_user?.email}");
          notifyListeners();
        } else {
          debugPrint("⚠️ Aucun utilisateur trouvé dans Hive ni Firebase.");
        }
      } else {
        debugPrint("⚠️ Aucun utilisateur actuellement connecté.");
      }
    } catch (e) {
      debugPrint("❌ Erreur lors du chargement de l'utilisateur : $e");
    }
  }

  /// 🔄 **Mise à jour des informations utilisateur**
  Future<void> updateUser(UserModel user) async {
    try {
      await _userService.updateUser(user);
      if (_user != user) {
        _user = user;
        notifyListeners();
      }
      debugPrint("✅ Utilisateur mis à jour : ${user.email}");
    } catch (e) {
      debugPrint("❌ Erreur lors de la mise à jour de l'utilisateur : $e");
    }
  }

  /// 🔥 **Connexion avec email et mot de passe**
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      UserModel? user = await _authService.signInWithEmail(email, password);
      if (user != null) {
        _user = user;
        notifyListeners();
        debugPrint("✅ Connexion réussie : ${user.email}");
        return true;
      }
    } catch (e) {
      debugPrint("❌ Erreur lors de la connexion par email : $e");
    }
    return false;
  }

  /// 🆕 **Inscription avec email et mot de passe**
  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String profession,
  }) async {
    try {
      UserModel? user = await _authService.signUpWithEmail(
        name: name,
        email: email,
        password: password,
        phone: phone,
        profession: profession,
      );
      if (user != null) {
        _user = user;
        notifyListeners();
        debugPrint("✅ Inscription réussie : ${user.email}");
        return true;
      }
    } catch (e) {
      debugPrint("❌ Erreur lors de l'inscription : $e");
    }
    return false;
  }

  /// 🔐 **Connexion avec Google**
  Future<bool> signInWithGoogle() async {
    try {
      UserModel? user = await _authService.signInWithGoogle();
      if (user != null) {
        _user = user;
        notifyListeners();
        debugPrint("✅ Connexion Google réussie : ${user.email}");
        return true;
      }
    } catch (e) {
      debugPrint("❌ Erreur lors de la connexion avec Google : $e");
    }
    return false;
  }

  /// 🔐 **Connexion avec Apple**
  Future<bool> signInWithApple() async {
    try {
      UserModel? user = await _authService.signInWithApple();
      if (user != null) {
        _user = user;
        notifyListeners();
        debugPrint("✅ Connexion Apple réussie : ${user.email}");
        return true;
      }
    } catch (e) {
      debugPrint("❌ Erreur lors de la connexion avec Apple : $e");
    }
    return false;
  }

  /// 🔄 **Déconnexion de l'utilisateur**
  Future<void> signOut() async {
    try {
      await _userService.initHive(); // ✅ Assurer que Hive est prêt avant la suppression locale

      if (_user?.id != null) {
        await _userService.deleteUserFromHive(_user!.id); // ✅ Supprime l'utilisateur localement
      } else {
        debugPrint("⚠️ Aucune donnée utilisateur à supprimer en local.");
      }

      // Vérifier si l'utilisateur est connecté à internet
      var connectivityResult = await Connectivity().checkConnectivity();
      if ([ConnectivityResult.wifi, ConnectivityResult.mobile].contains(connectivityResult)) {
        await FirebaseService.signOut(); // Déconnecter Firebase si Internet est dispo
        debugPrint("✅ Déconnexion Firebase réussie !");
      } else {
        debugPrint("⚠️ Pas d'Internet : Déconnexion locale uniquement.");
      }

      _user = null;
      notifyListeners();
      debugPrint("✅ Déconnexion réussie !");
    } catch (e) {
      debugPrint("❌ Erreur lors de la déconnexion : $e");
    }
  }
}


