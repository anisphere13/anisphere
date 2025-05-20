/// Copilot Prompt : Service Firebase pour AniSphère.
/// Gère la déconnexion, la lecture/écriture Firestore des utilisateurs et animaux.
/// Utilise FirebaseAuth + Firestore.
/// Inclut gestion des erreurs, logs conditionnels, fusion automatique des données.
/// IA-ready et modulaire.
library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';

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
      debugPrint("❌ Erreur déconnexion Firebase : $e");
    }
  }

  /// 💾 Sauvegarder ou mettre à jour un utilisateur
  Future<bool> saveUser(UserModel user) async {
    try {
      if (user.id.isEmpty) return false;

      await db.collection('users').doc(user.id).set(
            user.toJson(),
            SetOptions(merge: true),
          );
      debugPrint("✅ Utilisateur sauvegardé : ${user.email}");
      return true;
    } catch (e) {
      debugPrint("❌ Erreur enregistrement utilisateur : $e");
      return false;
    }
  }

  /// 🔄 Récupération utilisateur
  Future<UserModel?> getUser(String userId) async {
    try {
      if (userId.isEmpty) return null;

      final doc = await db.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint("❌ Erreur récupération utilisateur : $e");
    }
    return null;
  }

  /// 🗑️ Suppression utilisateur
  Future<bool> deleteUser(String userId) async {
    try {
      if (userId.isEmpty) return false;

      await db.collection('users').doc(userId).delete();
      debugPrint("✅ Utilisateur supprimé : $userId");
      return true;
    } catch (e) {
      debugPrint("❌ Erreur suppression utilisateur : $e");
      return false;
    }
  }

  /// 🐾 Sauvegarder ou mettre à jour un animal
  Future<bool> saveAnimal(AnimalModel animal) async {
    try {
      if (animal.id.isEmpty) return false;

      await db.collection('animals').doc(animal.id).set(
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

  /// 🔄 Récupération animal
  Future<AnimalModel?> getAnimal(String animalId) async {
    try {
      if (animalId.isEmpty) return null;

      final doc = await db.collection('animals').doc(animalId).get();
      if (doc.exists && doc.data() != null) {
        return AnimalModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint("❌ Erreur récupération animal : $e");
    }
    return null;
  }

  /// 🗑️ Suppression animal
  Future<bool> deleteAnimal(String animalId) async {
    try {
      if (animalId.isEmpty) return false;

      await db.collection('animals').doc(animalId).delete();
      debugPrint("✅ Animal supprimé : $animalId");
      return true;
    } catch (e) {
      debugPrint("❌ Erreur suppression animal : $e");
      return false;
    }
  }
}
