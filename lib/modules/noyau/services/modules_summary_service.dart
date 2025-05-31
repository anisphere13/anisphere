/// 🧠 modules_summary_service.dart — AniSphère
/// Génère dynamiquement des résumés IA pour les modules actifs
/// Utilisé sur l’écran d’accueil IA pour afficher une vue synthétique.
/// Se base sur IAContext, les services locaux et l’état des modules.

library;

import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
import 'package:anisphere/modules/noyau/logic/ia_context.dart';

class ModuleSummary {
  final String moduleName;
  final String summary;
  final String icon; // Peut servir pour un widget visuel
  final bool isPremium;

  ModuleSummary({
    required this.moduleName,
    required this.summary,
    required this.icon,
    required this.isPremium,
  });
}

class ModulesSummaryService {
  final AnimalService animalService;
  final IAContext context;

  ModulesSummaryService({
    required this.animalService,
    required this.context,
  });

  /// 📦 Récupère les résumés IA pour les modules actifs
  Future<List<ModuleSummary>> generateSummaries() async {
    final List<ModuleSummary> summaries = [];
    final animals = await animalService.getAllAnimals();
    final statuses = await ModulesService.getAllModulesStatus(); // ✅ await ici

    for (final module in ModulesService.allModules) {
      final status = statuses[module]; // ✅ plus d’erreur ici
      if (status == "actif") {
        switch (module) {
          case "Santé":
            summaries.add(
              ModuleSummary(
                moduleName: "Santé",
                summary: animals.isEmpty
                    ? "Aucun suivi de santé en cours"
                    : "${animals.length} animaux enregistrés pour le suivi santé",
                icon: "🩺",
                isPremium: false,
              ),
            );
            break;

          case "Éducation":
            summaries.add(
              ModuleSummary(
                moduleName: "Éducation",
                summary: context.animalCount == 0
                    ? "Aucun apprentissage lancé"
                    : "${context.animalCount} animaux à accompagner",
                icon: "📚",
                isPremium: false,
              ),
            );
            break;

          case "Dressage":
            summaries.add(
              ModuleSummary(
                moduleName: "Dressage",
                summary: "Dressage intelligent disponible",
                icon: "🎯",
                isPremium: true,
              ),
            );
            break;

          default:
            summaries.add(
              ModuleSummary(
                moduleName: module,
                summary: "Résumé IA non défini",
                icon: "✨",
                isPremium: false,
              ),
            );
        }
      }
    }

    return summaries;
  }
}
