/// 🤖 IAMaster — IA maîtresse locale AniSphère
/// Coordonne la logique IA (locale & future cloud)
/// Centralise les décisions, les logs et la stratégie IA
/// Utilisé au démarrage, dans les exécuteurs IA et dans la logique UX
/// 🤖 IAMaster — IA maîtresse locale AniSphère
/// Coordonne la logique IA (locale & future cloud)
/// Centralise les décisions, les logs et la stratégie IA
/// Utilisé au démarrage, dans les exécuteurs IA et dans la logique UX

import 'package:flutter/foundation.dart';
import '../services/local_storage_service.dart';
import '../services/firebase_service.dart';
import 'ia_logger.dart';
import 'ia_flag.dart';

class IAMaster {
  static final IAMaster instance = IAMaster._internal();

  static const String _iaLogsKey = "ia_logs";
  static const String _lastSyncKey = "last_ia_sync";

  final FirebaseService _firebaseService;

  IAMaster._internal({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  /// 🧠 Initialisation IA (au lancement)
  Future<void> initialize() async {
    debugPrint("🤖 IA maîtresse initialisée.");
    await IALogger.log(message: "IA_START");
  }

  /// ☁️ Simulation future de synchronisation IA cloud
  Future<void> syncCloudIA() async {
    await IALogger.log(message: "SYNC_CLOUD_START");
    await Future.delayed(const Duration(seconds: 1)); // Simule traitement
    await recordSync();
    await IALogger.log(message: "SYNC_CLOUD_SUCCESS");
    debugPrint("☁️ Sync IA cloud terminée.");
  }

  /// 🔄 Enregistrement de la dernière sync IA cloud
  Future<void> recordSync() async {
    final now = DateTime.now().toIso8601String();
    await LocalStorageService.set(_lastSyncKey, now);
  }

  /// 📅 Lecture de la dernière date de synchronisation
  DateTime? getLastSyncDate() {
    final raw = LocalStorageService.get(_lastSyncKey);
    if (raw is String) {
      try {
        return DateTime.parse(raw);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  /// 🧹 Nettoyage automatique des anciens logs IA
  Future<void> cleanOldLogs() async {
    final logs = LocalStorageService.get(_iaLogsKey, defaultValue: <String>[]).cast<String>();
    if (logs.length > 50) {
      final trimmed = logs.sublist(logs.length - 30);
      await LocalStorageService.set(_iaLogsKey, trimmed);
      await IALogger.log(message: "LOGS_TRIMMED");
    }
  }

  /// 🔖 Gestion des flags IA (UI)
  final Map<IAFlag, bool> _flags = {};

  bool getFlag(IAFlag flag) => _flags[flag] ?? false;

  void setFlag(IAFlag flag, bool value) {
    _flags[flag] = value;
  }

  void resetAllFlags() {
    _flags.clear();
  }

  /// 🧠 Décision IA du mode UX (utilisé pour accueil / adaptative UI)
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
}
