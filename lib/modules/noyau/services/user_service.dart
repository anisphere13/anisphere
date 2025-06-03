/// Copilot Prompt : Service utilisateur AniSphère (Firebase + Hive).
/// Gère synchronisation cloud, sauvegarde locale, suppression, et MAJ IA.
/// Optimisé pour IA maîtresse, offline-first, multi-profil.

library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/user_model.dart';
import 'package:anisphere/modules/noyau/services/ia_sync_service.dart';

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

  Future<void> init() async {
    await _initHive();
  }

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

  Future<Box<UserModel>?> getOrInitBox() async {
    if (_userBox == null || !_userBox!.isOpen) {
      await _initHive();
    }
    return _userBox;
  }

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

  UserModel? getUserFromHive() {
    try {
      return _userBox?.get(currentUserKey);
    } catch (e) {
      _logError("getUserFromHive", e);
      return null;
    }
  }

  Future<void> syncUserData(String userId) async {
    final user = await getUserFromFirebase(userId);
    if (user != null) {
      await updateUserLocally(user);
    }
  }

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

  Future<void> updateUserLocally(UserModel user) async {
    try {
      final box = await getOrInitBox();
      await box?.put(currentUserKey, user);
    } catch (e) {
      _logError("updateUserLocally", e);
    }
  }

  Future<bool> updateUser(UserModel user) async {
    final success = await saveUserToFirebase(user);
    if (success) {
      await updateUserLocally(user);
      if (user.iaPremium) {
        await IASyncService.instance.syncUser(user); // ← Correction ici !
      }
    }
    return success;
  }

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
        activeModules: List<String>.from(
            fields['activeModules'] ?? currentUser.activeModules),
        updatedAt: DateTime.now(),
      );
      await updateUser(updatedUser);
    }
  }

  Future<void> activateModule(String moduleKey) async {
    final currentUser = getUserFromHive();
    if (currentUser == null) return;

    final newModules = Set<String>.from(currentUser.activeModules)
      ..add(moduleKey);
    final updatedUser = currentUser.copyWith(
      activeModules: newModules.toList(),
      updatedAt: DateTime.now(),
    );
    await updateUser(updatedUser);
  }

  Future<void> deactivateModule(String moduleKey) async {
    final currentUser = getUserFromHive();
    if (currentUser == null) return;

    final newModules = List<String>.from(currentUser.activeModules)
      ..removeWhere((m) => m == moduleKey);
    final updatedUser = currentUser.copyWith(
      activeModules: newModules,
      updatedAt: DateTime.now(),
    );
    await updateUser(updatedUser);
  }

  Future<void> deleteUserLocally() async {
    try {
      final box = await getOrInitBox();
      await box?.delete(currentUserKey);
      debugPrint("✅ Utilisateur supprimé localement");
    } catch (e) {
      _logError("deleteUserLocally", e);
    }
  }

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

  Future<void> deleteUserFromHive(String userId) async {
    try {
      final box = await getOrInitBox();
      await box?.delete(userId);
    } catch (e) {
      _logError("deleteUserFromHive", e);
    }
  }

  Future<DateTime?> getLastSyncDate() async {
    final user = getUserFromHive();
    return user?.updatedAt;
  }

  /// Log d'erreur typé, visible uniquement en debug.
  void _logError(String context, Object error) {
    assert(() {
      debugPrint("❌ Erreur $context : $error");
      return true;
    }());
  }

  /// Version asynchrone pour récupérer l'utilisateur localement (utile hors contexte Provider).
  Future<UserModel?> getLocalUser() async {
    try {
      final box = await getOrInitBox();
      return box?.get(currentUserKey);
    } catch (e) {
      _logError("getLocalUser", e);
      return null;
    }
  }

  /// Version asynchrone pour sauvegarder l'utilisateur localement (utile hors Provider).
  Future<void> saveUserLocally(UserModel user) async {
    try {
      final box = await getOrInitBox();
      await box?.put(currentUserKey, user);
      assert(() {
        debugPrint("✅ Utilisateur sauvegardé localement !");
        return true;
      }());
    } catch (e) {
      _logError("saveUserLocally", e);
    }
  }

  /// Supprime tous les utilisateurs locaux (utile pour debug ou reset).
  Future<void> clearAllLocalUsers() async {
    try {
      final box = await getOrInitBox();
      await box?.clear();
      assert(() {
        debugPrint("✅ Tous les utilisateurs locaux supprimés.");
        return true;
      }());
    } catch (e) {
      _logError("clearAllLocalUsers", e);
    }
  }
}
