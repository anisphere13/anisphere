/// Service utilisateur AniSphère (Firebase + Hive).
/// Gère synchronisation cloud, sauvegarde locale, suppression, et MAJ IA.
/// Optimisé pour IA maîtresse, offline-first, multi-profil.
library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore firestore;
  static const String userBoxName = 'user_data';
  static const String currentUserKey = 'current_user';

  Box<UserModel>? _userBox;
  final bool skipHiveInit;

  UserService({
    FirebaseFirestore? firestore,
    Box<UserModel>? testBox,
    this.skipHiveInit = false,
  }) : firestore = firestore ?? FirebaseFirestore.instance {
    if (testBox != null) {
      _userBox = testBox;
    }
  }

  /// Initialisation du service (Hive)
  Future<void> init() async {
    await _initHive();
  }

  /// Initialisation de Hive
  Future<void> _initHive() async {
    if (skipHiveInit || _userBox != null) return;
    try {
      _userBox = Hive.isBoxOpen(userBoxName)
          ? Hive.box<UserModel>(userBoxName)
          : await Hive.openBox<UserModel>(userBoxName);
      debugPrint("✅ Hive User Box initialisée !");
    } catch (e) {
      _logError("initHive", e);
    }
  }

  /// 📦 Retourne la box Hive ou tente de l'ouvrir
  Future<Box<UserModel>?> getOrInitBox() async {
    if (_userBox == null || !_userBox!.isOpen) {
      await _initHive();
    }
    return _userBox;
  }

  /// 🔄 Récupère un utilisateur depuis Firebase
  Future<UserModel?> getUserFromFirebase(String userId) async {
    try {
      final doc = await firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        final user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
        await updateUserLocally(user);
        return user;
      }
    } catch (e) {
      _logError("getUserFromFirebase", e);
    }
    return null;
  }

  /// 🔍 Récupère l’utilisateur localement
  UserModel? getUserFromHive() {
    try {
      return _userBox?.get(currentUserKey);
    } catch (e) {
      _logError("getUserFromHive", e);
      return null;
    }
  }

  /// 🔁 Synchronise Firebase → Hive
  Future<void> syncUserData(String userId) async {
    final user = await getUserFromFirebase(userId);
    if (user != null) {
      await updateUserLocally(user);
    }
  }

  /// 💾 Sauvegarde dans Firebase (merge)
  Future<bool> saveUserToFirebase(UserModel user) async {
    try {
      await firestore
          .collection('users')
          .doc(user.id)
          .set(user.toJson(), SetOptions(merge: true));
      return true;
    } catch (e) {
      _logError("saveUserToFirebase", e);
      return false;
    }
  }

  /// 🧠 Mise à jour locale (Hive)
  Future<void> updateUserLocally(UserModel user) async {
    try {
      final box = await getOrInitBox();
      await box?.put(currentUserKey, user);
    } catch (e) {
      _logError("updateUserLocally", e);
    }
  }

  /// 🔁 MAJ cloud + locale combinée
  Future<bool> updateUser(UserModel user) async {
    final success = await saveUserToFirebase(user);
    if (success) {
      await updateUserLocally(user);
    }
    return success;
  }

  /// ✏️ MAJ partielle via Map (Firebase + Hive)
  Future<void> updateUserFields(Map<String, dynamic> fields) async {
    final currentUser = getUserFromHive();
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(
        name: fields['name'],
        email: fields['email'],
        phone: fields['phone'],
        profilePicture: fields['profilePicture'],
        profession: fields['profession'],
        ownedSpecies: fields['ownedSpecies'],
        ownedAnimals: fields['ownedAnimals'],
        preferences: fields['preferences'],
        moduleRoles: fields['moduleRoles'],
        updatedAt: DateTime.now(),
      );
      await updateUser(updatedUser);
    }
  }

  /// 🗑️ Supprimer localement
  Future<void> deleteUserLocally() async {
    try {
      final box = await getOrInitBox();
      await box?.delete(currentUserKey);
      debugPrint("✅ Utilisateur supprimé localement");
    } catch (e) {
      _logError("deleteUserLocally", e);
    }
  }

  /// 🗑️ Supprimer dans Firebase
  Future<bool> deleteUser(String userId) async {
    try {
      await firestore.collection('users').doc(userId).delete();
      await deleteUserLocally();
      return true;
    } catch (e) {
      _logError("deleteUser", e);
      return false;
    }
  }

  /// 🗑️ Supprimer un utilisateur précis dans Hive
  Future<void> deleteUserFromHive(String userId) async {
    try {
      final box = await getOrInitBox();
      await box?.delete(userId);
    } catch (e) {
      _logError("deleteUserFromHive", e);
    }
  }

  /// Méthode privée pour logguer les erreurs
  void _logError(String context, Object error) {
    debugPrint("❌ Erreur $context : $error");
  }
}
