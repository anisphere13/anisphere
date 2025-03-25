import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';

class FirebaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 🔥 **Déconnexion de l'utilisateur**
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
      debugPrint("✅ Utilisateur déconnecté.");
    } catch (e) {
      debugPrint("❌ Erreur lors de la déconnexion : $e");
    }
  }

  /// 🔥 **Sauvegarde ou mise à jour d'un utilisateur dans Firestore**
  static Future<bool> saveUserToFirebase(UserModel user) async {
    try {
      if (user.id.isEmpty) {
        debugPrint("⚠️ ID utilisateur vide, annulation de la sauvegarde.");
        return false;
      }

      await _db.collection('users').doc(user.id).set(
            user.toJson(),
            SetOptions(merge: true), // Empêche d’écraser les anciennes données
          );
      debugPrint("✅ Utilisateur sauvegardé : ${user.email}");
      return true;
    } catch (e) {
      debugPrint("❌ Erreur enregistrement utilisateur : $e");
      return false;
    }
  }

  /// 🔄 **Récupération d'un utilisateur depuis Firestore**
  static Future<UserModel?> getUserFromFirebase(String userId) async {
    try {
      if (userId.isEmpty) {
        debugPrint("⚠️ ID utilisateur vide, récupération annulée.");
        return null;
      }

      DocumentSnapshot doc = await _db.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        debugPrint("✅ Utilisateur récupéré : ${doc.id}");
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint("❌ Erreur récupération utilisateur : $e");
    }
    return null;
  }

  /// 🗑️ **Suppression d'un utilisateur**
  static Future<bool> deleteUserFromFirebase(String userId) async {
    try {
      if (userId.isEmpty) {
        debugPrint("⚠️ ID utilisateur vide, suppression annulée.");
        return false;
      }

      await _db.collection('users').doc(userId).delete();
      debugPrint("✅ Utilisateur supprimé : $userId");
      return true;
    } catch (e) {
      debugPrint("❌ Erreur suppression utilisateur : $e");
      return false;
    }
  }

  /// 🐾 **Sauvegarde ou mise à jour d'un animal**
  static Future<bool> saveAnimalToFirebase(AnimalModel animal) async {
    try {
      if (animal.id.isEmpty) {
        debugPrint("⚠️ ID animal vide, annulation de la sauvegarde.");
        return false;
      }

      await _db.collection('animals').doc(animal.id).set(
            animal.toJson(),
            SetOptions(merge: true),
          );
      debugPrint("✅ Animal sauvegardé : ${animal.name}");
      return true;
    } catch (e) {
      debugPrint("❌ Erreur enregistrement animal : $e");
      return false;
    }
  }

  /// 🔄 **Récupération d'un animal**
  static Future<AnimalModel?> getAnimalFromFirebase(String animalId) async {
    try {
      if (animalId.isEmpty) {
        debugPrint("⚠️ ID animal vide, récupération annulée.");
        return null;
      }

      DocumentSnapshot doc = await _db.collection('animals').doc(animalId).get();
      if (doc.exists && doc.data() != null) {
        debugPrint("✅ Animal récupéré : ${doc.id}");
        return AnimalModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint("❌ Erreur récupération animal : $e");
    }
    return null;
  }

  /// 🗑️ **Suppression d'un animal**
  static Future<bool> deleteAnimalFromFirebase(String animalId) async {
    try {
      if (animalId.isEmpty) {
        debugPrint("⚠️ ID animal vide, suppression annulée.");
        return false;
      }

      await _db.collection('animals').doc(animalId).delete();
      debugPrint("✅ Animal supprimé : $animalId");
      return true;
    } catch (e) {
      debugPrint("❌ Erreur suppression animal : $e");
      return false;
    }
  }
}



