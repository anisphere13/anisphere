/// Copilot Prompt : Moteur de règles IA AniSphère.
/// Applique dynamiquement les règles définies dans ia_rules.dart selon le contexte.
/// Peut être appelé automatiquement par IAMaster ou d’autres modules.
/// Retourne des suggestions IA, alertes ou actions à exécuter.
import '../models/animal_model.dart';
import 'ia_rules.dart';
import 'ia_logger.dart';

class IARuleEngine {
  /// 🔍 Analyse les animaux de l'utilisateur
  /// Retourne une liste d’actions IA recommandées
  static Future<List<String>> analyzeAnimals(List<AnimalModel> animals) async {
    List<String> actions = [];

    if (IARules.shouldSuggestAnimalOnboarding(animals)) {
      actions.add("suggest_add_animal");
      await IALogger.log("RULE: suggest_add_animal");
    }

    for (final animal in animals) {
      if (IARules.isAnimalProfileIncomplete(animal)) {
        actions.add("warn_incomplete_profile_${animal.id}");
        await IALogger.log("RULE: incomplete_profile - ${animal.id}");
      }

      if (IARules.isAnimalInactive(animal)) {
        actions.add("flag_inactive_${animal.id}");
        await IALogger.log("RULE: inactivity - ${animal.id}");
      }
    }

    if (actions.isEmpty) {
      await IALogger.log("RULE_ENGINE: no_action_needed");
    }

    return actions;
  }
}
