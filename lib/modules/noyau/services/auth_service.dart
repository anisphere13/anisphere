import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'user_service.dart';
import '../models/user_model.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  // 🔥 Obtenir l'utilisateur actuellement connecté
  User? get currentUser => _auth.currentUser;

  /// 🔥 **Connexion avec email et mot de passe**
  Future<UserModel?> signInWithEmail(String email, String password) async {
    try {
      if (_auth.currentUser != null) {
        await _auth.signOut(); // 🔥 Déconnecter une session active avant de se reconnecter
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) return null;

      // 🔄 Récupérer l'utilisateur depuis Firestore
      UserModel? user = await _userService.getUserFromFirebase(userCredential.user!.uid);

      if (user == null) {
        debugPrint("⚠️ Utilisateur non trouvé dans Firebase !");
      }

      return user;
    } catch (e) {
      debugPrint("❌ Erreur connexion : $e");
      return null;
    }
  }

  /// 🆕 **Inscription avec email et mot de passe**
  Future<UserModel?> signUpWithEmail({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String profession,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) return null;

      UserModel newUser = UserModel(
        id: credential.user!.uid,
        name: name,
        email: email,
        phone: phone,
        profilePicture: "",
        profession: profession,
        ownedSpecies: {},
        ownedAnimals: [],
        preferences: {"theme": "light", "notifications": true},
        moduleRoles: {},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _userService.saveUserToFirebase(newUser);
      return newUser;
    } on FirebaseAuthException catch (e) {
      debugPrint("❌ Erreur lors de l'inscription : ${e.message}");
      return null;
    } catch (e) {
      debugPrint("❌ Erreur inattendue lors de l'inscription : $e");
      return null;
    }
  }

  /// 🔐 **Connexion avec Google**
  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.user == null) return null;

      // 🔄 Vérifier si l'utilisateur existe déjà dans Firebase
      UserModel? user = await _userService.getUserFromFirebase(userCredential.user!.uid);

      // 🔥 Si l'utilisateur n'existe pas encore, on le crée dans Firestore
      if (user == null) {
        user = UserModel(
          id: userCredential.user!.uid,
          name: googleUser.displayName ?? "Utilisateur",
          email: googleUser.email,
          phone: "",
          profilePicture: googleUser.photoUrl ?? "",
          profession: "",
          ownedSpecies: {},
          ownedAnimals: [],
          preferences: {"theme": "light", "notifications": true},
          moduleRoles: {},
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await _userService.saveUserToFirebase(user);
      }

      return user;
    } catch (e) {
      debugPrint("❌ Erreur connexion Google : $e");
      return null;
    }
  }

  /// 🔐 **Connexion avec Apple**
  Future<UserModel?> signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );

      final OAuthProvider oAuthProvider = OAuthProvider("apple.com");
      final AuthCredential credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.user == null) return null;

      // 🔄 Vérifier si l'utilisateur existe déjà
      UserModel? user = await _userService.getUserFromFirebase(userCredential.user!.uid);

      // 🔥 Si l'utilisateur n'existe pas, on le crée
      if (user == null) {
        user = UserModel(
          id: userCredential.user!.uid,
          name: appleCredential.givenName ?? "Utilisateur Apple",
          email: appleCredential.email ?? "",
          phone: "",
          profilePicture: "",
          profession: "",
          ownedSpecies: {},
          ownedAnimals: [],
          preferences: {"theme": "light", "notifications": true},
          moduleRoles: {},
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await _userService.saveUserToFirebase(user);
      }

      return user;
    } catch (e) {
      debugPrint("❌ Erreur connexion Apple : $e");
      return null;
    }
  }

  /// 🔄 **Récupérer la session de l'utilisateur actuel**
  Future<UserModel?> getCurrentUser() async {
    if (currentUser != null) {
      debugPrint("✅ Utilisateur actuel trouvé : ${currentUser!.email}");
      return await _userService.getUserFromFirebase(currentUser!.uid);
    }
    debugPrint("❌ Aucun utilisateur actuel trouvé.");
    return null;
  }

  /// 🔄 **Déconnexion de l'utilisateur**
  Future<void> signOut() async {
    if (currentUser != null) {
      await _auth.signOut();
      await _userService.deleteUserFromHive(currentUser!.uid); // 🔥 Correction ici
    }
    debugPrint("✅ Utilisateur déconnecté !");
  }

  /// 🔄 **Réinitialiser le mot de passe**
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      debugPrint("✅ Email de réinitialisation envoyé !");
    } on FirebaseAuthException catch (e) {
      debugPrint("❌ Erreur lors de la réinitialisation du mot de passe : ${e.message}");
    } catch (e) {
      debugPrint("❌ Erreur inattendue lors de la réinitialisation du mot de passe : $e");
    }
  }
}
