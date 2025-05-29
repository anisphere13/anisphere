/// Copilot Prompt : Provider AnimalProvider pour AniSphère.
/// Gère la liste locale des animaux via AnimalService.
/// Permet d’ajouter, supprimer, synchroniser et notifier l’UI.
/// IA-compatible, optimisé offline-first et modulaire.

import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';

class AnimalProvider extends ChangeNotifier {
  final AnimalService _animalService;
  final Map<String, AnimalModel> _animals = {};

  AnimalProvider({AnimalService? animalService})
      : _animalService = animalService ?? AnimalService();

  /// 🔄 Initialisation complète
  Future<void> init() async {
    await _animalService.init();
    await _loadLocalAnimals();
  }

  /// 📥 Chargement des animaux locaux
  Future<void> _loadLocalAnimals() async {
    final box = await _animalService._initHive();
    final Map<String, AnimalModel> loaded = {};
    for (var key in box.keys) {
      final animal = box.get(key);
      if (animal != null) {
        loaded[key] = animal;
      }
    }
    _animals.clear();
    _animals.addAll(loaded);
    notifyListeners();
  }

  /// 🐾 Accès en lecture seule
  List<AnimalModel> get animals => _animals.values.toList();

  /// ➕ Ajout ou modification
  Future<void> saveAnimal(AnimalModel animal) async {
    await _animalService.saveAnimal(animal);
    _animals[animal.id] = animal;
    notifyListeners();
  }

  /// 🔄 Synchronisation spécifique
  Future<void> syncAnimal(String id) async {
    final updated = await _animalService.syncAnimal(id);
    if (updated != null) {
      _animals[id] = updated;
      notifyListeners();
    }
  }

  /// ❌ Suppression
  Future<void> deleteAnimal(String id) async {
    await _animalService.deleteAnimal(id);
    _animals.remove(id);
    notifyListeners();
  }

  /// 🔍 Récupération par ID
  AnimalModel? getAnimal(String id) => _animals[id];
}
