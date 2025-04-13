/// Copilot Prompt : IA maîtresse AniSphère.
/// Coordonne la logique IA locale et cloud, centralise les décisions.
/// Pilote la synchronisation adaptative, les suggestions, et les logs IA.
/// Prévu pour évoluer vers un système prédictif temps réel.
import 'package:flutter/foundation.dart';
import '../services/local_storage_service.dart';
import '../services/firebase_service.dart';

class IAMaster {
  static const String _iaLogsKey = "ia_logs";
  static const String _lastSyncKey = "last_ia_sync";

  final FirebaseService _firebaseService;

  IAMaster({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  /// 🧠 Initialisation IA (au lancement de l'app)
  Future<void> initialize() async {
    debugPrint("🤖 IA maîtresse initialisée.");
    await logEvent("IA_START");
  }

  /// 📥 Log d’un événement IA (local)
  Future<void> logEvent(String event) async {
    final timestamp = DateTime.now().toIso8601String();
    final logs = LocalStorageService.get(_iaLogsKey, defaultValue: <String>[]).cast<String>();
    logs.add("[$timestamp] $event");
    await LocalStorageService.set(_iaLogsKey, logs);
  }

  /// 🔄 Enregistrement de la dernière sync IA cloud
  Future<void> recordSync() async {
    final now = DateTime.now().toIso8601String();
    await LocalStorageService.set(_lastSyncKey, now);
  }

  /// 🧠 Décision UX IA selon le contexte
  String decideUXMode({
    required bool isFirstLaunch,
    required bool isOffline,
    required bool hasAnimals,
  }) {
    if (isOffline) return "offline_mode";
    if (isFirstLaunch) return "onboarding_mode";
    if (!hasAnimals) return "empty_state";
    return "normal_mode";
  }

  /// ☁️ Simulation de synchronisation IA cloud
  Future<void> syncCloudIA() async {
    await logEvent("SYNC_CLOUD_START");
    await Future.delayed(const Duration(seconds: 1));
    await recordSync();
    await logEvent("SYNC_CLOUD_SUCCESS");
    debugPrint("☁️ Sync IA cloud terminée.");
  }

  /// 🧹 Nettoyage automatique des anciens logs
  Future<void> cleanOldLogs() async {
    final logs = LocalStorageService.get(_iaLogsKey, defaultValue: <String>[]).cast<String>();
    if (logs.length > 50) {
      final trimmed = logs.sublist(logs.length - 30);
      await LocalStorageService.set(_iaLogsKey, trimmed);
      await logEvent("LOGS_TRIMMED");
    }
  }
}

