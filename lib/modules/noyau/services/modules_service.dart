/// Copilot Prompt : Service de gestion des modules AniSphère.
/// Gère l’état des modules (activé, premium, disponible).
/// Persiste les statuts avec LocalStorageService.
/// Utilisé par ModulesScreen et IA pour déterminer les accès.

library;

import 'package:anisphere/modules/noyau/services/local_storage_service.dart';

class ModulesService {
  static const List<String> allModules = [
    "Santé",
    "Éducation",
    "Dressage",
    // 🔽 Ajouter ici les modules futurs
  ];

  /// 🔄 Récupère le statut d’un module : actif, premium, disponible
  static String getStatus(String moduleName) {
    return LocalStorageService.get("module_status_$moduleName", defaultValue: "disponible");
  }

  /// ✅ Active un module (accessible immédiatement)
  static Future<void> activate(String moduleName) async {
    await LocalStorageService.set("module_status_$moduleName", "actif");
  }

  /// 💎 Marque un module comme premium (IA avancée ou payante)
  static Future<void> markPremium(String moduleName) async {
    await LocalStorageService.set("module_status_$moduleName", "premium");
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
}
