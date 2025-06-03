/// Copilot Prompt : BackupService complet pour AniSphère.
/// Sauvegarde automatiquement les données Hive vers Firebase.
/// Gère également la restauration des données sauvegardées.
/// Compatible avec IAContext, AnimalService, UserService.
/// Optimisé offline-first, sécurisé, gestion erreurs propre.

library;

import 'package:flutter/foundation.dart';
import 'package:anisphere/modules/noyau/services/firebase_service.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';

class BackupService {
  final UserService userService;
  final AnimalService animalService;
  final FirebaseService firebaseService;

  BackupService({
    required this.userService,
    required this.animalService,
    FirebaseService? firebaseService,
  }) : firebaseService = firebaseService ?? FirebaseService();

  /// 💾 Sauvegarde complète vers Firebase
  Future<bool> performBackup() async {
    try {
      // Correction ici : on attend bien l'utilisateur local (async)
      final user = await userService.getLocalUser();
      final animals = await animalService.getAllAnimals();

      if (user == null) {
        _log("⚠️ Aucun utilisateur local trouvé, sauvegarde impossible.");
        return false;
      }

      await firebaseService.saveUser(user);
      for (AnimalModel animal in animals) {
        await firebaseService.saveAnimal(animal);
      }

      _log("✅ Sauvegarde complète effectuée avec succès.");
      return true;
    } catch (e) {
      _log("❌ Erreur lors de la sauvegarde : $e");
      return false;
    }
  }

  /// ♻️ Restauration complète depuis Firebase vers Hive
  Future<bool> restoreBackup(String userId) async {
    try {
      final user = await firebaseService.getUser(userId);
      if (user == null) {
        _log("⚠️ Aucun utilisateur trouvé dans la sauvegarde cloud.");
        return false;
      }

      await userService.saveUserLocally(user);
      // On suppose que la méthode existe dans FirebaseService
      final animals = await firebaseService.getAllAnimals(ownerId: userId);
      for (AnimalModel animal in animals) {
        await animalService.updateLocalAnimal(animal);
      }

      _log("✅ Restauration complète effectuée avec succès.");
      return true;
    } catch (e) {
      _log("❌ Erreur lors de la restauration : $e");
      return false;
    }
  }

  /// 🗑️ Supprime toutes les données sauvegardées sur Firebase
  Future<bool> deleteBackup(String userId) async {
    try {
      final animals = await firebaseService.getAllAnimals(ownerId: userId);
      for (AnimalModel animal in animals) {
        await firebaseService.deleteAnimal(animal.id);
      }
      await firebaseService.deleteUser(userId);

      _log("✅ Sauvegarde supprimée avec succès.");
      return true;
    } catch (e) {
      _log("❌ Erreur lors de la suppression de la sauvegarde : $e");
      return false;
    }
  }

  /// 🕗 Dernière sauvegarde effectuée (utile pour l'UI)
  Future<DateTime?> getLastBackupDate(String userId) async {
    try {
      final user = await firebaseService.getUser(userId);
      return user?.updatedAt;
    } catch (e) {
      _log("❌ Erreur récupération date dernière sauvegarde : $e");
      return null;
    }
  }

  /// Log typé, visible uniquement en debug.
  void _log(String message) {
    assert(() {
      debugPrint("[BackupService] $message");
      return true;
    }());
  }
}
