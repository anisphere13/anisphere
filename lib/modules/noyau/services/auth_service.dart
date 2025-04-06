/// Service d'authentification pour AniSphère.
/// Gère email/password, Google, Apple, création, reset, logout.
/// Intègre Firebase Auth et Firebase Firestore (via UserService).

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/foundation.dart';

import '../models/user_model.dart';
import 'user_service.dart';

class AuthService {
  final FirebaseAuth _auth;
  final UserService _userService;

  AuthService({
    FirebaseAuth? firebaseAuth,
    UserService? userService,
  })  : _auth = firebaseAuth ?? FirebaseAuth.instance,
        _userService = userService ?? UserService();

  /// 🔎 Utilisateur actuellement connecté
  User? get currentUser => _auth.currentUser;

  /// 📩 Connexion avec email / mot de passe
  Future<UserModel?> signInWithEmail(String email, String password) async {
    return await _signIn(() async {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    });
  }

  /// 🆕 Inscription avec email / mot de passe
  Future<UserModel?> signUpWithEmail({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String profession,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) return null;

      final newUser = _createDefaultUser(
        id: firebaseUser.uid,
        name: name,
        email: email,
        phone: phone,
        profession: profession,
      );

      await _userService.saveUserToFirebase(newUser);
      return newUser;
    } catch (e) {
      _logError("signUpWithEmail", e);
      return null;
    }
  }

  /// 🔐 Connexion avec Google
  Future<UserModel?> signInWithGoogle() async {
    return await _signIn(() async {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return (await _auth.signInWithCredential(credential)).user;
    }, createDefaultUser: (firebaseUser) {
      return _createDefaultUser(
        id: firebaseUser.uid,
        name: "Utilisateur",
        email: firebaseUser.email ?? "",
        profilePicture: firebaseUser.photoURL ?? "",
      );
    });
  }

  /// 🍏 Connexion avec Apple
  Future<UserModel?> signInWithApple() async {
    return await _signIn(() async {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauth = OAuthProvider("apple.com");
      final credential = oauth.credential(
        idToken: appleCredential.identityToken,
      );

      return (await _auth.signInWithCredential(credential)).user;
    }, createDefaultUser: (firebaseUser) {
      return _createDefaultUser(
        id: firebaseUser.uid,
        name: appleCredential.givenName ?? "Utilisateur Apple",
        email: appleCredential.email ?? "",
      );
    });
  }

  /// 🔎 Récupérer l'utilisateur actuel depuis Firestore
  Future<UserModel?> getCurrentUser() async {
    final current = currentUser;
    if (current != null) {
      return await _userService.getUserFromFirebase(current.uid);
    }
    return null;
  }

  /// 🔓 Déconnexion
  Future<void> signOut() async {
    if (currentUser != null) {
      await _auth.signOut();
      await _userService.deleteUserFromHive(currentUser!.uid);
    }
  }

  /// 🔁 Réinitialisation du mot de passe
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      debugPrint("✅ Email de réinitialisation envoyé !");
    } catch (e) {
      _logError("resetPassword", e);
    }
  }

  /// 🔒 Vérification de l'email
  Future<void> verifyEmail() async {
    final user = currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      debugPrint("✅ Email de vérification envoyé !");
    }
  }

  /// Méthode privée pour gérer les connexions
  Future<UserModel?> _signIn(
    Future<User?> Function() signInMethod, {
    UserModel Function(User)? createDefaultUser,
  }) async {
    try {
      final firebaseUser = await signInMethod();
      if (firebaseUser == null) return null;

      UserModel? user = await _userService.getUserFromFirebase(firebaseUser.uid);
      if (user == null && createDefaultUser != null) {
        user = createDefaultUser(firebaseUser);
        await _userService.saveUserToFirebase(user);
      }
      return user;
    } catch (e) {
      _logError("signIn", e);
      return null;
    }
  }

  /// Méthode privée pour créer un utilisateur par défaut
  UserModel _createDefaultUser({
    required String id,
    required String name,
    required String email,
    String phone = "",
    String profilePicture = "",
    String profession = "",
  }) {
    return UserModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      profilePicture: profilePicture,
      profession: profession,
      ownedSpecies: {},
      ownedAnimals: [],
      preferences: {"theme": "light", "notifications": true},
      moduleRoles: {},
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Méthode privée pour logguer les erreurs
  void _logError(String context, Object error) {
    debugPrint("❌ $context : $error");
  }
}