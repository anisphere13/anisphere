// Copilot Prompt : Service Firebase pour AniSphère.
// Gère la déconnexion, la lecture/écriture Firestore des utilisateurs et animaux.
// Utilise FirebaseAuth + Firestore.
// Inclut gestion des erreurs, logs conditionnels, fusion automatique des données.
// IA-ready et modulaire.

library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/noyau/models/photo_model.dart';

class FirebaseService {
  final FirebaseFirestore db;
  final FirebaseAuth auth;

  FirebaseService({
    FirebaseFirestore? firestore,
    FirebaseAuth? firebaseAuth,
  })  : db = firestore ?? FirebaseFirestore.instance,
        auth = firebaseAuth ?? FirebaseAuth.instance;

  /// 🔓 Déconnexion Firebase
  Future<void> signOut() async {
    try {
      await auth.signOut();
      debugPrint("✅ Utilisateur déconnecté.");
    } catch (e) {
      _logError("signOut", e);
    }
  }

  /// 💾 Sauvegarder ou mettre à jour un utilisateur
  Future<bool> saveUser(UserModel user, {bool forTraining = false}) async {
    if (user.id.isEmpty) return false;
    try {
      await db
          .collection(forTraining ? 'training_users' : 'users')
          .doc(user.id)
          .set(user.toJson(), SetOptions(merge: true));
      debugPrint("✅ Utilisateur sauvegardé : ${user.email} (${forTraining ? "training" : "prod"})");
      return true;
    } catch (e) {
      _logError("saveUser", e);
      return false;
    }
  }

  /// 🔄 Récupération utilisateur
  Future<UserModel?> getUser(String userId) async {
    if (userId.isEmpty) return null;
    try {
      final doc = await db.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      _logError("getUser", e);
    }
    return null;
  }

  /// 🗑️ Suppression utilisateur
  Future<bool> deleteUser(String userId) async {
    if (userId.isEmpty) return false;
    try {
      await db.collection('users').doc(userId).delete();
      debugPrint("✅ Utilisateur supprimé : $userId");
      return true;
    } catch (e) {
      _logError("deleteUser", e);
      return false;
    }
  }

  /// 🐾 Sauvegarder ou mettre à jour un animal
  Future<bool> saveAnimal(AnimalModel animal, {bool forTraining = false}) async {
    if (animal.id.isEmpty) return false;
    try {
      await db
          .collection(forTraining ? 'training_animals' : 'animals')
          .doc(animal.id)
          .set(animal.toJson(), SetOptions(merge: true));
      debugPrint("✅ Animal sauvegardé : ${animal.name} (${forTraining ? "training" : "prod"})");
      return true;
    } catch (e) {
      _logError("saveAnimal", e);
      return false;
    }
  }

  /// 🖼️ Sauvegarder ou mettre à jour une photo
  Future<bool> savePhoto(PhotoModel photo) async {
    if (photo.id.isEmpty) return false;
    try {
      await db.collection('photos').doc(photo.id).set(
            photo.toJson(),
            SetOptions(merge: true),
          );
      debugPrint('✅ Photo sauvegardée : ${photo.id}');
      return true;
    } catch (e) {
      _logError('savePhoto', e);
      return false;
    }
  }

  /// 🔄 Récupération animal
  Future<AnimalModel?> getAnimal(String animalId) async {
    if (animalId.isEmpty) return null;
    try {
      final doc = await db.collection('animals').doc(animalId).get();
      if (doc.exists && doc.data() != null) {
        return AnimalModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      _logError("getAnimal", e);
    }
    return null;
  }

  /// 🗑️ Suppression animal
  Future<bool> deleteAnimal(String animalId) async {
    if (animalId.isEmpty) return false;
    try {
      await db.collection('animals').doc(animalId).delete();
      debugPrint("✅ Animal supprimé : $animalId");
      return true;
    } catch (e) {
      _logError("deleteAnimal", e);
      return false;
    }
  }

  /// 📥 Récupération de tous les animaux (pour un utilisateur ou global)
  Future<List<AnimalModel>> getAllAnimals({String? ownerId}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> query;
      if (ownerId != null) {
        query = await db
            .collection('animals')
            .where('ownerId', isEqualTo: ownerId)
            .get();
      } else {
        query = await db.collection('animals').get();
      }

      return query.docs
          .map((doc) => AnimalModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      _logError("getAllAnimals", e);
      return [];
    }
  }

  /// 🧠 Envoi libre pour modules IA
  Future<void> sendModuleData(String moduleName, Map<String, dynamic> data) async {
    try {
      await db.collection("training_modules").add({
        "module": moduleName,
        "timestamp": DateTime.now().toIso8601String(),
        "data": data,
      });
      debugPrint("✅ Module $moduleName envoyé.");
    } catch (e) {
      _logError("sendModuleData", e);
    }
  }

  /// 🧠 Envoi de métriques IA locales
  Future<void> sendIAFeedback(Map<String, dynamic> metrics) async {
    try {
      await db.collection("ia_feedback").add({
        "timestamp": DateTime.now().toIso8601String(),
        "metrics": metrics,
      });
      debugPrint("✅ Feedback IA envoyé.");
    } catch (e) {
      _logError("sendIAFeedback", e);
    }
  }

  /// 💌 Envoi d'un feedback lié aux notifications
  Future<void> sendNotificationFeedback(Map<String, dynamic> data) async {
    try {
      await db.collection('notification_feedback').add(data);
      debugPrint('✅ Notification feedback envoyé.');
    } catch (e) {
      _logError('sendNotificationFeedback', e);
    }
  }

  /// ☁️ Envoi des logs IA (compressés ou découpés)
  Future<void> sendIALogs(Map<String, dynamic> data) async {
    try {
      await db.collection('ia_logs').add(data);
      debugPrint('✅ IA logs envoyés.');
    } catch (e) {
      _logError('sendIALogs', e);
      rethrow;
    }
  }

  void _logError(String context, Object error) {
    debugPrint("❌ [$context] FirebaseService error : $error");
  }
}
