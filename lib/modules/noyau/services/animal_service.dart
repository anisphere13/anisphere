/// Copilot Prompt : Service AnimalService pour AniSphère.
/// Gère le stockage local (Hive), la synchro Firebase, les ajouts/suppressions.
/// IA-compatible, testable, optimisé offline-first.
/// Service des animaux pour AniSphère.
/// Gère la lecture/écriture locale Hive, la synchronisation avec Firebase,
/// et la suppression. Utilise FirebaseService en interne.
/// IA-compatible, testable, offline-first.
library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/animal_model.dart';
import 'package:anisphere/modules/noyau/services/firebase_service.dart';

class AnimalService {
  static const String animalBoxName = 'animal_data';
  final FirebaseService _firebaseService;
  Box<AnimalModel>? _animalBox;
  final bool skipHiveInit;

  AnimalService({
    FirebaseService? firebaseService,
    Box<AnimalModel>? testBox,
    this.skipHiveInit = false,
  }) : _firebaseService = firebaseService ?? FirebaseService() {
    if (testBox != null) {
      _animalBox = testBox;
    }
  }

  /// 🔧 Initialise le service Hive
  Future<void> init() async {
    await _initHive();
  }

  /// 📦 Initialise ou récupère la boîte Hive
  Future<void> _initHive() async {
    if (skipHiveInit || _animalBox != null) return;
    try {
      _animalBox = Hive.isBoxOpen(animalBoxName)
          ? Hive.box<AnimalModel>(animalBoxName)
          : await Hive.openBox<AnimalModel>(animalBoxName);
      _log("📦 Boîte Hive des animaux initialisée.");
    } catch (e) {
      _log("❌ Erreur d'initialisation Hive (animaux) : $e");
    }
  }

  /// 🔁 Synchronise un animal depuis Firebase
  Future<AnimalModel?> syncAnimal(String animalId) async {
    try {
      final animal = await _firebaseService.getAnimal(animalId);
      if (animal != null) {
        await updateLocalAnimal(animal);
      }
      return animal;
    } catch (e) {
      _log("❌ Erreur lors de la synchronisation de l'animal : $e");
      return null;
    }
  }

  /// 📥 Ajoute ou met à jour un animal localement
  Future<void> updateLocalAnimal(AnimalModel animal) async {
    try {
      await _initHive();
      await _animalBox?.put(animal.id, animal);
    } catch (e) {
      _log("❌ Erreur lors de la mise à jour locale de l'animal : $e");
    }
  }

  /// 🔍 Récupère un animal localement
  AnimalModel? getAnimal(String animalId) {
    try {
      return _animalBox?.get(animalId);
    } catch (e) {
      _log("❌ Erreur lors de la récupération de l'animal : $e");
      return null;
    }
  }

  /// 💾 Envoie un animal à Firebase et met à jour localement
  Future<bool> saveAnimal(AnimalModel animal) async {
    try {
      final success = await _firebaseService.saveAnimal(animal);
      if (success) {
        await updateLocalAnimal(animal);
      }
      return success;
    } catch (e) {
      _log("❌ Erreur lors de l'enregistrement de l'animal : $e");
      return false;
    }
  }

  /// 🗑️ Supprime un animal localement
  Future<void> deleteLocalAnimal(String animalId) async {
    try {
      await _initHive();
      await _animalBox?.delete(animalId);
    } catch (e) {
      _log("❌ Erreur lors de la suppression locale de l'animal : $e");
    }
  }

  /// 🗑️ Supprime un animal globalement
  Future<bool> deleteAnimal(String animalId) async {
    try {
      final success = await _firebaseService.deleteAnimal(animalId);
      if (success) {
        await deleteLocalAnimal(animalId);
      }
      return success;
    } catch (e) {
      _log("❌ Erreur lors de la suppression globale de l'animal : $e");
      return false;
    }
  }

  /// 📚 Récupère tous les animaux locaux
  Future<List<AnimalModel>> getAllAnimals() async {
    try {
      await _initHive();
      return _animalBox?.values.toList() ?? [];
    } catch (e) {
      _log("❌ Erreur lors de la récupération de tous les animaux : $e");
      return [];
    }
  }

  /// 🔒 Log conditionné par kDebugMode
  void _log(String message) {
    if (kDebugMode) {
      debugPrint(message);
    }
  }
}
