// 🤖 IAMaster — IA mâtresse locale AniSphère
// Coordonne la logique IA (locale & cloud)
// Centralise les décisions, les logs et la stratégie IA
// Utilisé au démarrage, dans les exécuteurs IA et la logique UX
// Copilot Prompt : "IAMaster manages local IA logic and triggers CloudSyncService when needed"

library;

import 'package:flutter/foundation.dart';
import '../services/local_storage_service.dart';
import '../services/cloud_sync_service.dart';
import '../services/offline_sync_queue.dart';
import '../services/offline_photo_queue.dart' as offline_queue;
import '../services/notification_feedback_service.dart';
import '../models/animal_model.dart';
import '../models/user_model.dart';
import '../models/photo_model.dart';
import '../models/notification_feedback_model.dart';
import 'ia_photo_analyzer.dart';
import 'dart:io';
import '../../messagerie/logic/ia_message_analyzer.dart';
import 'ia_logger.dart';
import 'ia_flag.dart';
import 'ia_channel.dart';

class IAMaster {
  static final IAMaster instance = IAMaster._internal();

  static const String _iaLogsKey = "ia_logs";
  static const String _lastSyncKey = "last_ia_sync";

  final CloudSyncService _cloudSyncService = CloudSyncService();
  final NotificationFeedbackService _notificationFeedbackService =
      NotificationFeedbackService();

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

  /// 📸 Analyse locale d'une photo puis envoi ou mise en attente.
  Future<void> analyzeAndPushPhoto(File file) async {
    final analysis = await IAPhotoAnalyzer().analyze(file);
    final photo = PhotoModel(
      id: analysis['hash'],
      userId: analysis['userId'] ?? '',
      animalId: analysis['animalId'] ?? '',
      localPath: file.path,
      createdAt: DateTime.now(),
      uploaded: false,
      remoteUrl: null,
    );
    try {
      await _cloudSyncService.pushPhotoData(photo);
      await IALogger.log(
        message: 'PUSH_PHOTO_${photo.id}',
        channel: IAChannel.execution,
      );
    } catch (e) {
      await offline_queue.OfflinePhotoQueue.addTask(
        offline_queue.PhotoTask(
          photo: photo,
          animalId: photo.animalId,
          userId: photo.userId,
          uploaded: photo.uploaded,
          remoteUrl: photo.remoteUrl ?? '',
        ),
      );
      debugPrint('⚠️ analyzeAndPushPhoto : file offline');
    }
  }

  /// 🔁 Sauvegarde d'un retour utilisateur sur une notification
  Future<void> pushNotificationFeedback(
      NotificationFeedbackModel feedback) async {
    try {
      await _notificationFeedbackService.saveFeedback(feedback);
      await IALogger.log(
        message: 'NOTIF_FEEDBACK_${feedback.notificationId}',
        channel: IAChannel.notification,
      );
    } catch (e) {
      debugPrint('❌ pushNotificationFeedback : $e');
    }
  }

  /// 📨 Analyse un message utilisateur et envoie le résultat au cloud
  Future<Map<String, String>> analyzeAndPushMessage(
      String conversationId, String message) async {
    final analysis = IAMessageAnalyzer().analyze(message);
    try {
      await _cloudSyncService.pushMessagingData(conversationId, {
        'message': message,
        'intent': analysis['intent'],
        'feedback': analysis['feedback'],
        'timestamp': DateTime.now().toIso8601String(),
      });
      await IALogger.log(
        message: 'MESSAGE_${analysis['intent']}',
        channel: IAChannel.user,
      );
    } catch (e) {
      debugPrint('❌ analyzeAndPushMessage : $e');
    }
    return analysis;
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
          if (task.type.startsWith('message:')) {
            final convoId = task.type.split(':').last;
            await _cloudSyncService.pushMessagingData(convoId, task.data);
          } else {
            debugPrint("❓ Type de tâche non géré : ${task.type}");
          }
      }
    });
    await offline_queue.OfflinePhotoQueue.processQueue((pt) async {
      await _cloudSyncService.pushPhotoData(pt.photo);
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