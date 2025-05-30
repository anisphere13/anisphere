/// 🧠 IARuleEngine — Moteur de règles IA AniSphère
/// Applique dynamiquement les règles définies dans ia_rules.dart selon le contexte
/// Appelé automatiquement par IAMaster ou IAExecutor
/// Retourne des suggestions IA, alertes ou actions à exécuter
library;
import '../models/animal_model.dart';
import 'ia_rules.dart';
import 'ia_logger.dart';
import 'ia_channel.dart';
import 'package:anisphere/modules/noyau/logic/ia_context.dart';

class IARuleEngine {
  /// 🔍 Analyse les animaux de l'utilisateur
  /// Retourne une liste d’actions IA recommandées
  static Future<List<String>> analyzeAnimals(List<AnimalModel> animals) async {
    List<String> actions = [];

    if (IARules.shouldSuggestAnimalOnboarding(animals)) {
      actions.add("suggest_add_animal");
      await IALogger.log(
        message: "RULE: suggest_add_animal",
        channel: IAChannel.rule,
      );
    }

    for (final animal in animals) {
      if (IARules.isAnimalProfileIncomplete(animal)) {
        actions.add("warn_incomplete_profile_${animal.id}");
        await IALogger.log(
          message: "RULE: incomplete_profile - ${animal.id}",
          channel: IAChannel.rule,
        );
      }

      if (IARules.isAnimalInactive(animal)) {
        actions.add("flag_inactive_${animal.id}");
        await IALogger.log(
          message: "RULE: inactivity - ${animal.id}",
          channel: IAChannel.rule,
        );
      }
    }

    if (actions.isEmpty) {
      await IALogger.log(
        message: "RULE_ENGINE: no_action_needed",
        channel: IAChannel.rule,
      );
    }

    return actions;
  }

  /// 🔁 Évaluation rapide sans modèle animal (via contexte uniquement)
  static List<String> evaluate(IAContext context) {
    final List<String> actions = [];

    if (context.isFirstLaunch) {
      actions.add("show_ui_suggestion_card");
    }

    if (context.hasAnimals && context.animalCount > 0) {
      actions.add("sync_animals");
    }

    if (context.lastSyncDate != null &&
        DateTime.now().difference(context.lastSyncDate!).inDays > 365) {
      actions.add("notify_identity_update_needed");
    }

    if (context.animalCount == 0) {
      actions.add("suggest_add_animal");
    }

    if (actions.isEmpty) {
      // Log uniquement en debug
      assert(() {
        IALogger.log(
          message: "RULE_ENGINE: no_contextual_action",
          channel: IAChannel.rule,
        );
        return true;
      }());
    }

    return actions;
  }
}

