/// Service d'authentification pour AniSphère.
/// Gère email/password, Google, Apple, création, reset, logout.
/// Intègre Firebase Auth et Firebase Firestore (via UserService).
library;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/foundation.dart';
import 'biometric_auth_service.dart';

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

  User? get currentUser => _auth.currentUser;

  Future<UserModel?> signInWithEmail(String email, String password) async {
    return await _signIn(() async {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    });
  }

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
      await _userService.saveUserLocally(newUser);
      return newUser;
    } catch (e) {
      _logError("signUpWithEmail", e);
      return null;
    }
  }

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

  Future<UserModel?> signInWithApple() async {
    AuthorizationCredentialAppleID? appleIdCredential;

    return await _signIn(() async {
      appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauth = OAuthProvider("apple.com");
      final credential = oauth.credential(
        idToken: appleIdCredential?.identityToken,
      );

      return (await _auth.signInWithCredential(credential)).user;
    }, createDefaultUser: (firebaseUser) {
      return _createDefaultUser(
        id: firebaseUser.uid,
        name: appleIdCredential?.givenName ?? "Utilisateur Apple",
        email: appleIdCredential?.email ?? "",
      );
    });
  }

  Future<UserModel?> getCurrentUser() async {
    final current = currentUser;
    if (current != null) {
      return await _userService.getUserFromFirebase(current.uid);
    }
    return null;
  }

  Future<void> signOut() async {
    if (currentUser != null) {
      await _auth.signOut();
      await _userService.deleteUserLocally();
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      debugPrint("✅ Email de réinitialisation envoyé !");
    } catch (e) {
      _logError("resetPassword", e);
    }
  }

  Future<void> verifyEmail() async {
    final user = currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      debugPrint("✅ Email de vérification envoyé !");
    }
  }

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
      activeModules: const [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      role: "user",
      iaPremium: false,
      lastIASync: null,
    );
  }

  void _logError(String context, Object error) {
    debugPrint("❌ $context : $error");
  }

  /// 🔐 Vérifie l'identité via biométrie ou PIN
  Future<bool> verifyBiometric() async {
    final service = BiometricAuthService();
    return service.authenticateOrPin('Confirmez votre identité');
  }
}
