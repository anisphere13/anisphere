/// Copilot Prompt : Logger IA centralisé AniSphère.
/// Permet de tracer les événements IA localement dans Hive.
/// Compatible avec la stratégie de nettoyage et synchronisation cloud.
library;
import 'package:flutter/foundation.dart';
import '../services/local_storage_service.dart';
import 'ia_config.dart';

class IALogger {
  static const String _key = "ia_logs";

  /// 🧠 Ajouter un log IA avec horodatage
  static Future<void> log(String event) async {
    final logs = LocalStorageService.get(_key, defaultValue: <String>[]).cast<String>();
    final timestamp = DateTime.now().toIso8601String();
    logs.add("[$timestamp] $event");
    await LocalStorageService.set(_key, logs);
    if (kDebugMode) debugPrint("🧠 Log IA ajouté : $event");
  }

  /// 🧹 Nettoyer les anciens logs IA (si trop nombreux)
  static Future<void> trimIfNeeded() async {
    final logs = LocalStorageService.get(_key, defaultValue: <String>[]).cast<String>();
    if (logs.length > IAConfig.maxLocalLogs) {
      final trimmed = logs.sublist(logs.length - IAConfig.logsTrimTarget);
      await LocalStorageService.set(_key, trimmed);
      await log("TRIM_LOGS");
    }
  }

  /// 🔎 Lire les logs
  static List<String> getLogs() {
    return LocalStorageService.get(_key, defaultValue: <String>[]).cast<String>();
  }

  /// 🧽 Réinitialiser tous les logs
  static Future<void> clearLogs() async {
    await LocalStorageService.set(_key, <String>[]);
    await log("CLEAR_LOGS");
  }
}
