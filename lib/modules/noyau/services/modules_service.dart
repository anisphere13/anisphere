// Copilot Prompt : Service de gestion des modules AniSphère.
// Gère l’état des modules (activé, premium, disponible).
// Persiste les statuts avec LocalStorageService.
// Utilisé par ModulesScreen et IA pour déterminer les accès.

library;

import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import 'package:anisphere/modules/noyau/models/module_model.dart';

class ModulesService {
  static const List<ModuleModel> availableModules = [
    ModuleModel(
      id: 'sante',
      name: 'Santé',
      description: 'Suivi santé et bien-être',
      category: 'Santé',
      icon: '🩺',
    ),
    ModuleModel(
      id: 'education',
      name: 'Éducation',
      description: 'Apprentissage et conseils',
      category: 'Éducation',
      icon: '📚',
    ),
    ModuleModel(
      id: 'dressage',
      name: 'Dressage',
      description: 'Entraînement avancé',
      category: 'Dressage',
      icon: '🎯',
      premium: true,
    ),
    // 🔽 Ajouter ici les modules futurs
  ];

  /// 📚 Association statique des catégories vers leurs modules.
  static const Map<String, List<Map<String, String>>> _modulesByCategory = {
    'Santé': [
      {
        'id': 'sante',
        'name': 'Santé',
        'description': 'Suivi des vaccins, visites, soins médicaux.',
      },
    ],
    'Éducation': [
      {
        'id': 'education',
        'name': 'Éducation',
        'description':
            'Programmes éducatifs IA et routines personnalisées.',
      },
    ],
    'Dressage': [
      {
        'id': 'dressage',
        'name': 'Dressage',
        'description': 'Entraînement avancé, objectifs, IA comparative.',
      },
    ],
    // 🔽 Ajouter ici d'autres catégories si nécessaire
  };

  /// 🔄 Récupère le statut d’un module : actif, premium, disponible
  static String getStatus(String moduleId) {
    return LocalStorageService.get("module_status_$moduleId",
        defaultValue: "disponible");
  }

  /// ✅ Active un module (accessible immédiatement)
  static Future<void> activate(String moduleId) async {
    await LocalStorageService.set("module_status_$moduleId", "actif");
  }

  /// 💎 Marque un module comme premium (IA avancée ou payante)
  static Future<void> markPremium(String moduleId) async {
    await LocalStorageService.set("module_status_$moduleId", "premium");
  }

  /// 🧼 Réinitialise tous les statuts (utile en debug ou réinitialisation)
  static Future<void> resetAllStatuses() async {
    for (final module in allModules) {
      await LocalStorageService.set("module_status_$module", "disponible");
    }
  }

  /// 📦 Renvoie une map complète des modules avec leur statut
  static Future<Map<String, String>> getAllModulesStatus() async {
    final Map<String, String> result = {};
    for (final module in allModules) {
      result[module] = getStatus(module);
    }
    return result;
  }

  /// ✅ Rend compatible IAExecutor : désactivation des modules inactifs
  Future<void> deactivateUnusedModules() async {
    for (final module in allModules) {
      final status = getStatus(module);
      if (status != "actif") {
        // Exemple : on pourrait forcer une action, log ou nettoyage
      }
    }
    // Rien à faire ici pour l’instant, méthode factice pour compatibilité IA
  }

  /// 📦 Méthode utilisée dans IAExecutor (correctif type)
  Future<Map<String, String>> getAllStatuses() async {
    return getAllModulesStatus();
  }

  /// Méthode compatible IA pour activation rapide
  Future<void> setActive(String moduleName) async {
    await activate(moduleName);
  }

  /// 🔍 Récupère les modules d'une catégorie donnée.
  Future<List<Map<String, String>>> getModulesByCategory(String category) async {
    return _modulesByCategory[category] ?? [];
  }
}
