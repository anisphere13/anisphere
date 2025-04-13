/// Règles intelligentes AniSphère.
/// Contient des règles métiers IA : seuils d’alerte, détections comportementales,
/// logiques de notifications ou déclencheurs IA.
/// S’appuie sur les données locales et le contexte utilisateur.

import 'package:flutter/foundation.dart';
import '../models/animal_model.dart';

class IARules {
  /// 🐾 Détection d’animaux sans interaction récente
  static bool isAnimalInactive(AnimalModel animal,
      {Duration threshold = const Duration(days: 14)}) {
    final now = DateTime.now();
    final delta = now.difference(animal.updatedAt);
    return delta > threshold;
  }

  /// ⚠️ Vérification de données manquantes critiques
  static bool isAnimalProfileIncomplete(AnimalModel animal) {
    return animal.name.isEmpty ||
        animal.species.isEmpty ||
        animal.ownerId.isEmpty;
  }

  /// 🔔 Déclenche une suggestion si aucun animal
  static bool shouldSuggestAnimalOnboarding(List<AnimalModel> animals) {
    return animals.isEmpty;
  }

  /// 📊 Détection d’anomalie basique sur comportement (exemple simplifié)
  static bool isWeightSuspicious(double previousWeight, double currentWeight) {
    final diff = (currentWeight - previousWeight).abs();
    final percent = (diff / previousWeight) * 100;
    return percent > 20; // ex : variation de +20% considérée anormale
  }

  /// 🧠 Retourne des règles UX intelligentes
  static String getSuggestedAction(List<AnimalModel> animals) {
    if (animals.isEmpty) return "add_first_animal";
    final inactive = animals.where((a) => isAnimalInactive(a)).toList();
    if (inactive.isNotEmpty) return "check_inactive_animals";
    return "dashboard_default";
  }

  /// 🧠 Décision UX IA selon le contexte
  static String decideUXMode({
    required bool isFirstLaunch,
    required bool isOffline,
    required bool hasAnimals,
  }) {
    if (isOffline) return "offline_mode";
    if (isFirstLaunch) return "onboarding_mode";
    if (!hasAnimals) return "empty_state";
    return "normal_mode";
  }
}
