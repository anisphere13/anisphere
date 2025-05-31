/// 🧠 modules_summary_service.dart — AniSphère
/// Génère dynamiquement des résumés IA pour les modules actifs.
/// Utilisé sur l’écran d’accueil IA pour afficher une vue synthétique.
/// Dépend de IAContext, AnimalService et ModulesService.

library;

import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
import 'package:anisphere/modules/noyau/logic/ia_context.dart';

class ModuleSummary {
  final String moduleName;
  final String summary;
  final String icon; // Icône visuelle pour l'UI
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

  /// 📦 Récupère les résumés IA pour les modules actifs.
  Future<List<ModuleSummary>> generateSummaries() async {
    final List<ModuleSummary> summaries = [];

    final animals = await animalService.getAllAnimals();
    final statuses = ModulesService.getAllModulesStatus(); // ⚠️ Pas de await (synchrone)

    for (final module in ModulesService.allModules) {
      final status = statuses[module] ?? "disponible";

      if (status == "actif") {
        switch (module) {
          case "Santé":
            summaries.add(
              ModuleSummary(
                moduleName: "Santé",
                summary: animals.isEmpty
                    ? "Aucun suivi de santé en cours"
                    : "${animals.length} animaux suivis en santé",
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
                    : "${context.animalCount} animaux en apprentissage",
                icon: "📚",
                isPremium: false,
              ),
            );
            break;

          case "Dressage":
            summaries.add(
              ModuleSummary(
                moduleName: "Dressage",
                summary: context.hasAnimals
                    ? "Dressage disponible pour ${context.animalCount} animaux"
                    : "Aucun animal enregistré pour le dressage",
                icon: "🎯",
                isPremium: true,
              ),
            );
            break;

          // 🔽 Ajoute ici les futurs modules avec des résumés spécifiques.
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
