// 🧠 modules_summary_service.dart — AniSphère
// Génère dynamiquement des résumés IA pour les modules actifs.
// Utilisé sur l’écran d’accueil IA pour afficher une vue synthétique.
// Dépend de IAContext, AnimalService et ModulesService.


import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
import 'package:anisphere/modules/noyau/logic/ia_context.dart';
import 'package:anisphere/l10n/app_localizations.dart';

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
  final AppLocalizations l10n;

  ModulesSummaryService({
    required this.animalService,
    required this.context,
    required this.l10n,
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
                    ? l10n.noHealthTracking
                    : "${animals.length} ${l10n.healthTrackingSummary}",
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
                    ? l10n.noTrainingStarted
                    : "${context.animalCount} ${l10n.trainingInProgress}",
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
                    ? "${l10n.trainingAvailableFor} ${context.animalCount}"
                    : l10n.noAnimalForTraining,
                icon: "🎯",
                isPremium: true,
              ),
            );
            break;

          case "Identité":
            summaries.add(
              ModuleSummary(
                moduleName: l10n.identityModuleTitle,
                summary: context.animalCount == 0
                    ? l10n.identityModuleDescription
                    : "${context.animalCount} ${l10n.identitiesRegistered}",
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
                summary: l10n.aiSummaryUndefined,
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
      return l10n.noActiveModule;
    }
    return summaries
        .map((s) => '${s.moduleName}: ${s.summary}')
        .join(' | ');
  }
}
