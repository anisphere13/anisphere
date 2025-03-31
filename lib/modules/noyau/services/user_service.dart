import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String userBoxName = 'user_data';
  late Box<UserModel> _userBox;

  /// 🔧 **Constructeur pour permettre l'injection de box personnalisée en test**
  UserService({Box<UserModel>? testBox}) {
    if (testBox != null) {
      _userBox = testBox;
    }
  }

  /// 🔄 **Initialisation globale du service**
  Future<void> init() async {
    await initHive();
  }

  /// 🔄 **Initialisation de Hive**
  Future<void> initHive() async {
    try {
      if (!Hive.isBoxOpen(userBoxName)) {
        _userBox = await Hive.openBox<UserModel>(userBoxName);
        debugPrint("✅ Hive User Box initialisée !");
      } else {
        _userBox = Hive.box<UserModel>(userBoxName);
      }
    } catch (e) {
      debugPrint("❌ Erreur d'initialisation Hive : $e");
    }
  }

  /// 🔄 **Récupérer un utilisateur depuis Firebase et le stocker localement**
  Future<UserModel?> getUserFromFirebase(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();

      if (doc.exists && doc.data() != null) {
        UserModel user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
        await updateUserLocally(user);
        return user;
      } else {
        debugPrint("⚠️ Utilisateur non trouvé dans Firebase !");
      }
    } catch (e) {
      debugPrint("❌ Erreur récupération Firebase : $e");
    }
    return null;
  }

  /// 💾 **Récupérer l'utilisateur depuis Hive (local)**
  UserModel? getUserFromHive() {
    try {
      if (!Hive.isBoxOpen(userBoxName)) {
        debugPrint("⚠️ Hive Box non ouverte !");
        return null;
      }
      return _userBox.get('current_user');
    } catch (e) {
      debugPrint("❌ Erreur récupération locale Hive : $e");
      return null;
    }
  }

  /// 🔄 **Synchroniser l'utilisateur entre Firebase et Hive**
  Future<void> syncUserData(String userId) async {
    UserModel? user = await getUserFromFirebase(userId);
    if (user != null) {
      await updateUserLocally(user);
    }
  }

  /// 🔥 **Enregistrer un utilisateur dans Firebase et localement**
  Future<bool> saveUserToFirebase(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(
            user.toJson(),
            SetOptions(merge: true),
          );
      await updateUserLocally(user);
      return true;
    } catch (e) {
      debugPrint("❌ Erreur enregistrement Firebase : $e");
      return false;
    }
  }

  /// 💾 **Mettre à jour l'utilisateur localement**
  Future<void> updateUserLocally(UserModel user) async {
    try {
      if (!Hive.isBoxOpen(userBoxName)) {
        debugPrint("⚠️ Hive Box non ouverte, tentative d'initialisation...");
        await initHive();
      }
      await _userBox.put('current_user', user);
    } catch (e) {
      debugPrint("❌ Erreur mise à jour locale Hive : $e");
    }
  }

  /// 🔄 **Mettre à jour Firebase et Hive**
  Future<bool> updateUser(UserModel user) async {
    bool success = await saveUserToFirebase(user);
    if (success) {
      await updateUserLocally(user);
    }
    return success;
  }

  /// 🔥 **Mettre à jour partiellement un utilisateur**
  Future<void> updateUserFields(Map<String, dynamic> updatedFields) async {
    try {
      UserModel? currentUser = getUserFromHive();
      if (currentUser != null) {
        UserModel updatedUser = currentUser.copyWith(
          name: updatedFields['name'] ?? currentUser.name,
          email: updatedFields['email'] ?? currentUser.email,
          phone: updatedFields['phone'] ?? currentUser.phone,
          profilePicture:
              updatedFields['profilePicture'] ?? currentUser.profilePicture,
          profession: updatedFields['profession'] ?? currentUser.profession,
          ownedSpecies: updatedFields['ownedSpecies'] ?? currentUser.ownedSpecies,
          ownedAnimals: updatedFields['ownedAnimals'] ?? currentUser.ownedAnimals,
          preferences: updatedFields['preferences'] ?? currentUser.preferences,
          moduleRoles: updatedFields['moduleRoles'] ?? currentUser.moduleRoles,
          updatedAt: DateTime.now(),
        );
        await updateUser(updatedUser);
      }
    } catch (e) {
      debugPrint("❌ Erreur mise à jour partielle utilisateur : $e");
    }
  }

  /// 🗑️ **Supprimer l'utilisateur localement**
  Future<void> deleteUserLocally() async {
    try {
      if (Hive.isBoxOpen(userBoxName)) {
        await _userBox.delete('current_user');
        debugPrint("✅ Utilisateur supprimé de Hive.");
      } else {
        debugPrint("⚠️ Impossible de supprimer : Hive Box non ouverte !");
      }
    } catch (e) {
      debugPrint("❌ Erreur suppression locale Hive : $e");
    }
  }

  /// 🗑️ **Supprimer un utilisateur de Firebase et Hive**
  Future<bool> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      await deleteUserLocally();
      return true;
    } catch (e) {
      debugPrint("❌ Erreur suppression Firebase : $e");
      return false;
    }
  }

  /// 🗑️ **Supprimer un utilisateur de Hive uniquement**
  Future<void> deleteUserFromHive(String userId) async {
    try {
      if (userId.isEmpty) {
        debugPrint("⚠️ ID utilisateur vide, suppression annulée !");
        return;
      }

      if (Hive.isBoxOpen(userBoxName)) {
        await _userBox.delete(userId);
        debugPrint("✅ Utilisateur supprimé de Hive : $userId");
      } else {
        debugPrint("⚠️ Hive Box non ouverte, suppression impossible !");
      }
    } catch (e) {
      debugPrint("❌ Erreur suppression utilisateur de Hive : $e");
    }
  }
}
