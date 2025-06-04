/// 🤖 IAMaster — IA mâtresse locale AniSphère
/// Coordonne la logique IA (locale & cloud)
/// Centralise les décisions, les logs et la stratégie IA
/// Utilisé au démarrage, dans les exécuteurs IA et la logique UX
/// Copilot Prompt : "IAMaster manages local IA logic and triggers CloudSyncService when needed"

library;

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import '../services/local_storage_service.dart';
import '../services/cloud_sync_service.dart';
import '../services/offline_sync_queue.dart';
import '../models/animal_model.dart';
import '../models/user_model.dart';
import 'ia_logger.dart';
import 'ia_flag.dart';
import 'ia_channel.dart';

class IAMaster {
  static final IAMaster instance = IAMaster._internal();

  static const String _iaLogsKey = "ia_logs";
  static const String _lastSyncKey = "last_ia_sync";

  final CloudSyncService _cloudSyncService = CloudSyncService();

  IAMaster._internal();
  /// Constructor accessible for testing purposes.
  @visibleForTesting
  IAMaster.test() : this._internal();

  /// 🧠 Initialisation IA (au lancement)
  Future<void> initialize() async {
    assert(() {
      debugPrint("🤖 IA mâtresse initialisée.");
      return true;
    }());
    await IALogger.log(
      message: "IA_START",
      channel: IAChannel.execution,
    );
  }

  /// ☁️ Synchronisation IA cloud réelle (premium uniquement)
  Future<void> syncCloudIA(String userId) async {
    try {
      await IALogger.log(
        message: "SYNC_CLOUD_START",
        channel: IAChannel.execution,
      );

      final logs = LocalStorageService.get(_iaLogsKey, defaultValue: <String>[])
          .cast<String>();
      await _cloudSyncService.syncFullIA(userId, logs);

      await recordSync();
      await IALogger.log(
        message: "SYNC_CLOUD_SUCCESS",
        channel: IAChannel.execution,
      );

      assert(() {
        debugPrint("☁️ Sync IA cloud terminée pour $userId.");
        return true;
      }());
    } catch (e) {
      assert(() {
        debugPrint("❌ [IAMaster] Erreur syncCloudIA : $e");
        return true;
      }());
    }
  }

  /// 🔁 Envoi automatique des données animal pour l'IA cloud ou file offline
  Future<void> pushAnimalData(AnimalModel animal) async {
    try {
      await _cloudSyncService.pushAnimalData(animal);
      await IALogger.log(
        message: "PUSH_ANIMAL_${animal.id}",
        channel: IAChannel.execution,
      );
    } catch (e) {
      await OfflineSyncQueue.addTask(SyncTask(
        type: "animal",
        data: animal.toJson(),
        timestamp: DateTime.now(),
      ));
      debugPrint("⚠️ pushAnimalData : ajout dans la file offline");
    }
  }

  /// 🔁 Envoi automatique des données utilisateur pour l'IA cloud ou file offline
  Future<void> pushUserData(UserModel user) async {
    try {
      await _cloudSyncService.pushUserData(user);
      await IALogger.log(
        message: "PUSH_USER_${user.id}",
        channel: IAChannel.execution,
      );
    } catch (e) {
      await OfflineSyncQueue.addTask(SyncTask(
        type: "user",
        data: user.toJson(),
        timestamp: DateTime.now(),
      ));
      debugPrint("⚠️ pushUserData : ajout dans la file offline");
    }
  }

  /// 🔄 Traitement manuel ou automatique de la file offline (ex: au retour online)
  Future<void> processOfflineQueue() async {
    await OfflineSyncQueue.processQueue((task) async {
      switch (task.type) {
        case "animal":
          await _cloudSyncService.pushAnimalData(AnimalModel.fromJson(task.data));
          break;
        case "user":
          await _cloudSyncService.pushUserData(UserModel.fromJson(task.data));
          break;
        default:
          debugPrint("❓ Type de tâche non géré : ${task.type}");
      }
    });
  }

  /// 🔀 Enregistrement de la dernière sync IA cloud
  Future<void> recordSync() async {
    final now = DateTime.now().toIso8601String();
    await LocalStorageService.set(_lastSyncKey, now);
  }

  /// 🗕️ Lecture de la dernière date de synchronisation
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
    try {
      final logs = LocalStorageService.get(_iaLogsKey, defaultValue: <String>[])
          .cast<String>();
      if (logs.length > 50) {
        final trimmed = logs.sublist(logs.length - 30);
        await LocalStorageService.set(_iaLogsKey, trimmed);
        await IALogger.log(
          message: "LOGS_TRIMMED",
          channel: IAChannel.execution,
        );
      }
    } catch (e) {
      assert(() {
        debugPrint("❌ [IAMaster] Erreur cleanOldLogs : $e");
        return true;
      }());
      rethrow;
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

  /// 🧠 Décision IA du mode UX
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