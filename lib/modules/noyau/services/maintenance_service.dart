/// Copilot Prompt : Service de maintenance automatique pour le noyau AniSphère.
/// Gère le nettoyage des logs, la purge Hive, la réinitialisation IA.
/// Appelé périodiquement par le noyau ou à chaque lancement si besoin.
/// Peut déclencher une sync IA ou une relance utilisateur.
library;
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'local_storage_service.dart';
import '../logic/ia_master.dart';

class MaintenanceService {
  final IAMaster _ia;

  MaintenanceService({IAMaster? ia}) : _ia = ia ?? IAMaster();

  /// 🔄 Lance toutes les maintenances critiques
  Future<void> runStartupChecks() async {
    await cleanPreferences();
    await _ia.cleanOldLogs();
    await fixHiveIfCorrupted();
    debugPrint("🔧 Maintenance startup terminée.");
  }

  /// 🧹 Supprime les préférences inutiles ou instables
  Future<void> cleanPreferences() async {
    final keysToRemove = [
      "debug_temp", "onboarding_done_debug", "outdated_config"
    ];
    for (var key in keysToRemove) {
      await LocalStorageService.remove(key);
    }
    debugPrint("🧹 Préférences nettoyées.");
  }

  /// 🛠️ Tente de réparer Hive s'il est corrompu (boîte fermée, crash...)
  Future<void> fixHiveIfCorrupted() async {
    final criticalBoxes = ['user_data', 'animal_data', 'settings'];

    for (final boxName in criticalBoxes) {
      if (!Hive.isBoxOpen(boxName)) {
        try {
          await Hive.openBox(boxName);
          debugPrint("✅ Boîte Hive réparée : $boxName");
        } catch (e) {
          debugPrint("❌ Erreur réouverture Hive : $boxName - $e");
        }
      }
    }
  }

  /// 🔁 Relance la sync IA si trop ancienne
  Future<void> autoSyncIfExpired() async {
    final lastSyncStr =
        LocalStorageService.get("last_ia_sync", defaultValue: "") as String;
    if (lastSyncStr.isEmpty) return await _ia.syncCloudIA();

    final lastSync = DateTime.tryParse(lastSyncStr);
    if (lastSync == null ||
        DateTime.now().difference(lastSync).inHours >= 12) {
      await _ia.syncCloudIA();
    }
  }
}
