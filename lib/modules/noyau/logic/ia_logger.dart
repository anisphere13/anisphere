/// 🧠 IALogger — Journal IA local pour AniSphère
/// Permet de tracer les événements IA localement dans Hive
/// Compatible avec la stratégie IA cloud et le nettoyage automatique
library;
import 'package:flutter/foundation.dart';

import '../services/local_storage_service.dart';
import 'ia_config.dart';
import 'ia_channel.dart';

class IALogger {
  static const String _key = "ia_logs";

  /// 🔐 Format standardisé : [horodatage] [canal] message
  static Future<void> log({
    required String message,
    required IAChannel channel,
  }) async {
    final logs = LocalStorageService.get(_key, defaultValue: <String>[]).cast<String>();
    final timestamp = DateTime.now().toIso8601String();
    final entry = "[$timestamp] [${channel.name}] $message";
    logs.add(entry);
    await LocalStorageService.set(_key, logs);

    if (kDebugMode) debugPrint("🧠 Log IA ajouté : $entry");

    await _trimIfNeeded(logs);
  }

  /// 🔎 Lire les logs
  static List<String> getLogs() {
    return LocalStorageService.get(_key, defaultValue: <String>[]).cast<String>();
  }

  /// 🧽 Supprimer tous les logs
  static Future<void> clearLogs() async {
    await LocalStorageService.set(_key, <String>[]);
    await log(message: "CLEAR_LOGS", channel: IAChannel.system);
  }

  /// 🧹 Si trop de logs, on garde uniquement les plus récents
  static Future<void> _trimIfNeeded(List<String> currentLogs) async {
    if (currentLogs.length > IAConfig.maxLocalLogs) {
      final trimmed = currentLogs.sublist(currentLogs.length - IAConfig.logsTrimTarget);
      await LocalStorageService.set(_key, trimmed);
      await log(message: "TRIM_LOGS", channel: IAChannel.system);
    }
  }
}
