/// 📐 IARules — Règles métiers IA pour AniSphère
/// Contient les règles d’analyse comportementale, UX et alertes IA
/// Appelé par IARuleEngine, IAMaster et les modules IA

library;

import '../models/animal_model.dart';

class IARules {
  /// 🐾 Détection d’animaux sans interaction récente
  static bool isAnimalInactive(AnimalModel animal,
      {Duration threshold = const Duration(days: 14)}) {
    final now = DateTime.now();
    final delta = now.difference(animal.updatedAt);
    return delta > threshold;
  }

  /// ⚠️ Vérifie si des champs critiques du profil sont manquants
  static bool isAnimalProfileIncomplete(AnimalModel animal) {
    return animal.name.isEmpty ||
        animal.species.isEmpty ||
        animal.ownerId.isEmpty;
  }

  /// 🔔 Déclenche une suggestion s’il n’y a aucun animal
  static bool shouldSuggestAnimalOnboarding(List<AnimalModel> animals) {
    return animals.isEmpty;
  }

  /// 📊 Analyse une variation de poids excessive
  static bool isWeightSuspicious(double previousWeight, double currentWeight) {
    final diff = (currentWeight - previousWeight).abs();
    if (previousWeight == 0) return false;
    final percent = (diff / previousWeight) * 100;
    return percent > 20; // ex : variation de +20% considérée anormale
  }

  /// 🧠 Renvoie une action UX IA basée sur les animaux présents
  static String getSuggestedAction(List<AnimalModel> animals) {
    if (animals.isEmpty) return "add_first_animal";
    final inactive = animals.where((a) => isAnimalInactive(a)).toList();
    if (inactive.isNotEmpty) return "check_inactive_animals";
    return "dashboard_default";
  }

  /// 🧠 Mode IA UX à utiliser selon le contexte
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
