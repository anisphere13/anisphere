// 🧠 modules_summary_service.dart — AniSphère
// Génère dynamiquement des résumés IA pour les modules actifs.
// Utilisé sur l’écran d’accueil IA pour afficher une vue synthétique.
// Dépend de IAContext, AnimalService et ModulesService.


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
    final statuses = await ModulesService.getAllModulesStatus();

    for (final module in ModulesService.modules) {
      final status = statuses[module.id] ?? "disponible";

      if (ModulesService.isActive(module.id)) {
        switch (module.name) {
          case "Santé":
            summaries.add(
              ModuleSummary(
                moduleName: "Santé",
                summary: animals.isEmpty
                    ? 'Aucun suivi de santé en cours'
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
                    ? 'Aucun apprentissage lancé'
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
                    ? "Dressage disponible pour ${context.animalCount}"
                    : 'Aucun animal enregistré pour le dressage',
                icon: "🎯",
                isPremium: true,
              ),
            );
            break;

          case "Identité":
            summaries.add(
              ModuleSummary(
                moduleName: 'Identité',
                summary: context.animalCount == 0
                    ? "Gérer l'identité de l'animal"
                    : "${context.animalCount} identités enregistrées",
                icon: "🆔",
                isPremium: false,
              ),
            );
            break;

          // 🔽 Ajoute ici les futurs modules avec des résumés spécifiques.
          default:
            summaries.add(
              ModuleSummary(
                moduleName: module.name,
                summary: 'Résumé IA non défini',
                icon: "✨",
                isPremium: false,
              ),
            );
        }
      }
    }

    return summaries;
  }

  /// 📝 Génère un résumé textuel pour l'UI.
  Future<String> generateSummaryText() async {
    final summaries = await generateSummaries();
    if (summaries.isEmpty) {
      return 'Aucun module actif';
    }
    return summaries
        .map((s) => '${s.moduleName}: ${s.summary}')
        .join(' | ');
  }
}
