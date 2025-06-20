// ☁️ CloudSyncService — AniSphère
// Service central de synchronisation cloud (Firebase ou autre backend)
// Toutes les données modules & noyau passent ici pour apprentissage IA cloud
// Utilisé par IAMaster, les modules, les IA locales

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/animal_model.dart';
import '../models/user_model.dart';
import '../models/support_ticket_model.dart';
import '../models/notification_feedback_model.dart';
import '../models/photo_model.dart';
import 'firebase_service.dart';
import '../services/offline_sync_queue.dart';
import '../services/offline_photo_queue.dart' as offline_queue;
import '../services/offline_gps_queue.dart';
import '../services/storage_optimizer.dart';
import 'anonymization_service.dart';

class CloudSyncService {
  final FirebaseService _firebaseService;
  final http.Client httpClient;
  final AnonymizationService _anonymizer;
  static const String _functionsBaseUrl =
      'https://REGION-PROJECT.cloudfunctions.net/iaApi';
  CloudSyncService({
    FirebaseService? firebaseService,
    http.Client? client,
    AnonymizationService? anonymizer,
  })  : _firebaseService = firebaseService ?? FirebaseService(),
        httpClient = client ?? http.Client(),
        _anonymizer = anonymizer ?? const AnonymizationService();
  /// 🔁 Envoie les données d’un animal pour apprentissage IA
  Future<void> pushAnimalData(AnimalModel animal) async {
    final sanitized = _anonymizer.anonymizeAnimal(animal);
    try {
      await _firebaseService.saveAnimal(sanitized, forTraining: true);
      debugPrint('☁️ Données animal envoyées au cloud pour IA : ${animal.name}');
    } catch (e) {
      debugPrint('❌ [CloudSync] Erreur pushAnimalData : $e');
      await OfflineSyncQueue.addTask(
        SyncTask(type: 'animal', data: sanitized.toJson(), timestamp: DateTime.now()),
      );
    }
  }
  /// 🔁 Envoie les données d’un utilisateur pour IA (profil, préférences)
  Future<void> pushUserData(UserModel user) async {
    final sanitized = _anonymizer.anonymizeUser(user);
    try {
      await _firebaseService.saveUser(sanitized, forTraining: true);
      debugPrint('☁️ Données utilisateur envoyées au cloud pour IA : ${user.email}');
    } catch (e) {
      debugPrint('❌ [CloudSync] Erreur pushUserData : $e');
      await OfflineSyncQueue.addTask(
        SyncTask(type: 'user', data: sanitized.toJson(), timestamp: DateTime.now()),
      );
    }
  }

  Future<void> pushCategoryData(String category, Map<String, dynamic> data) async {
    try {
      final uri = Uri.parse('$_functionsBaseUrl/ia_categories/$category/uploads');
      final res = await httpClient.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'items': [data]}),
      );
      if (res.statusCode >= 200 && res.statusCode < 300) {
        debugPrint('☁️ Données IA $category envoyées.');
        return;
      }
      throw HttpException('status ${res.statusCode}');
    } catch (e) {
      debugPrint('❌ [CloudSync] Erreur pushCategoryData : $e');
      await OfflineSyncQueue.addTask(SyncTask(
        type: 'category:$category',
        data: data,
        timestamp: DateTime.now(),
      ));
    }
  }
  /// 🔁 Envoie de données spécifiques à un module (format libre)
  Future<void> pushModuleData(String moduleName, Map<String, dynamic> data) async {
    final sanitized = _anonymizer.anonymizeMap(
      data,
      const ['userId', 'animalId', 'ownerId', 'email', 'phone'],
    );
    try {
      await _firebaseService.sendModuleData(moduleName, sanitized);
      debugPrint('☁️ Données module $moduleName envoyées au cloud.');
    } catch (e) {
      debugPrint('❌ [CloudSync] Erreur pushModuleData ($moduleName) : $e');
      await OfflineSyncQueue.addTask(
        SyncTask(type: 'module:$moduleName', data: sanitized, timestamp: DateTime.now()),
      );
    }
  }

  /// 🔁 Envoie un retour utilisateur (support/contact/bug)
  Future<void> pushSupportData(SupportTicketModel feedback) async {
    try {
      var optimized = feedback;
      if (feedback.attachments.isNotEmpty) {
        final optimizedPaths = await StorageOptimizer.optimizePaths(feedback.attachments);
        optimized = feedback.copyWith(attachments: optimizedPaths);
      }
      final sanitized = _anonymizer.anonymizeMap(
        optimized.toJson(),
        const ['userId', 'email', 'phone'],
      );
      await _firebaseService.sendModuleData('support', sanitized);
      debugPrint('☁️ Feedback support envoyé au cloud.');
    } catch (e) {
      debugPrint('❌ [CloudSync] Erreur pushSupportData : $e');
      final sanitized = _anonymizer.anonymizeMap(
        feedback.toJson(),
        const ['userId', 'email', 'phone'],
      );
      await OfflineSyncQueue.addTask(
        SyncTask(type: 'support', data: sanitized, timestamp: DateTime.now()),
      );
    }
  }

  /// 🔁 Envoie un retour suite à une notification
  Future<void> pushNotificationFeedback(NotificationFeedbackModel feedback) async {
    final sanitized = _anonymizer.anonymizeMap(
      feedback.toJson(),
      const ['userId'],
    );
    try {
      await _firebaseService.sendNotificationFeedback(sanitized);
      debugPrint('☁️ Feedback notification envoyé au cloud.');
    } catch (e) {
      debugPrint('❌ [CloudSync] Erreur pushNotificationFeedback : $e');
      await OfflineSyncQueue.addTask(
        SyncTask(
          type: OfflineSyncQueue.taskNotificationFeedback,
          data: sanitized,
          timestamp: DateTime.now(),
        ),
      );
    }
  }

  /// 🔁 Envoie d'un message analysé pour apprentissage IA
  Future<void> pushMessagingData(
      String conversationId, Map<String, dynamic> data) async {
    final sanitized = _anonymizer.anonymizeMap(
      data,
      const ['userId', 'animalId', 'ownerId', 'email', 'phone'],
    );
    try {
      await _firebaseService.sendModuleData('messaging/$conversationId', sanitized);
      debugPrint('☁️ Données messagerie envoyées pour $conversationId.');
    } catch (e) {
      debugPrint('❌ [CloudSync] Erreur pushMessagingData : $e');
      await OfflineSyncQueue.addTask(
        SyncTask(
          type: 'message:$conversationId',
          data: sanitized,
          timestamp: DateTime.now(),
        ),
      );
    }
  }

  /// 📊 Envoie d’un retour IA local (métriques, logs, feedbacks)
  Future<void> pushIAFeedback(Map<String, dynamic> metrics) async {
    final sanitized = _anonymizer.anonymizeMap(
      metrics,
      const ['userId', 'animalId', 'ownerId', 'email', 'phone'],
    );
    try {
      await _firebaseService.sendIAFeedback(sanitized);
      debugPrint('☁️ Feedback IA locale envoyé au cloud.');
    } catch (e) {
      debugPrint('❌ [CloudSync] Erreur pushIAFeedback : $e');
      await OfflineSyncQueue.addTask(
        SyncTask(type: 'ia_feedback', data: sanitized, timestamp: DateTime.now()),
      );
    }
  }

  /// 🖼️ Envoie une photo pour apprentissage IA ou la met en attente.
  Future<void> pushPhotoData(PhotoModel photo) async {
    final sanitized = _anonymizer.anonymizePhoto(photo);
    try {
      await _firebaseService.sendModuleData('photos', sanitized.toJson());
      debugPrint('☁️ Photo ${photo.id} envoyée au cloud.');
    } catch (e) {
      debugPrint('❌ [CloudSync] Erreur pushPhotoData : $e');
      await offline_queue.OfflinePhotoQueue.addTask(
        offline_queue.PhotoTask(
          photo: sanitized,
          animalId: sanitized.animalId,
          userId: sanitized.userId,
          uploaded: sanitized.uploaded,
          remoteUrl: sanitized.remoteUrl ?? '',
        ),
      );
    }
  }

  // Copilot: envoie un batch GPS et le met en attente si besoin
  Future<void> pushGPSData(GpsBatch batch) async {
    final data = batch.points
        .map((p) => {
              'lat': p.lat,
              'lon': p.lon,
              'timestamp': p.timestamp.toIso8601String(),
            })
        .toList();
    try {
      await _firebaseService.sendModuleData('gps', {'batch': data});
      debugPrint('☁️ Batch GPS envoyé (${batch.points.length} entrées).');
    } catch (e) {
      debugPrint('❌ [CloudSync] Erreur pushGPSData : $e');
      await OfflineGpsQueue.addBatch(batch);
    }
  }
  /// 📦 Synchro complète pour IAMaster (utilise les logs de l’app)
  Future<void> syncFullIA(String userId, List<String> logs) async {
    try {
      debugPrint('☁️ [CloudSyncService] Sync full IA pour $userId avec ${logs.length} logs.');
      if (logs.isEmpty) return;

      // Concatenate and compress logs
      final raw = logs.join('\n');
      final compressed = gzip.encode(utf8.encode(raw));
      final base64Logs = base64Encode(compressed);

      // Firestore has a ~1MB document limit, so chunk if needed
      const int maxSize = 900000; // keep some margin
      int index = 0;
      for (var i = 0; i < base64Logs.length; i += maxSize) {
        final chunk = base64Logs.substring(i, i + maxSize > base64Logs.length ? base64Logs.length : i + maxSize);
        await _firebaseService.sendIALogs({
          'userId': userId,
          'timestamp': DateTime.now().toIso8601String(),
          'chunkIndex': index++,
          'data': chunk,
        });
      }
    } catch (e) {
      debugPrint('❌ [CloudSyncService] Erreur syncFullIA : $e');
      await OfflineSyncQueue.addTask(
        SyncTask(
          type: 'ia_logs',
          data: {
            'userId': userId,
            'logs': logs,
          },
          timestamp: DateTime.now(),
        ),
      );
    }
  }
  /// 🔁 Rejoue toutes les tâches en attente dans la file offline
  Future<void> replayOfflineTasks() async {
    await OfflineSyncQueue.processQueue((task) async {
      switch (task.type) {
        case "animal":
          await _firebaseService.saveAnimal(
            AnimalModel.fromJson(task.data ?? {}),
            forTraining: true,
          );
          break;
        case "user":
          await _firebaseService.saveUser(
            UserModel.fromJson(task.data ?? {}),
            forTraining: true,
          );
          break;
        case "ia_feedback":
          await _firebaseService.sendIAFeedback(task.data ?? {});
          break;
        case 'ia_logs':
          final userId = task.data?['userId'] as String? ?? '';
          final logs = (task.data?['logs'] as List?)?.cast<String>() ?? [];
          await syncFullIA(userId, logs);
          break;
        case "support":
          await _firebaseService.sendModuleData('support', task.data ?? {});
          break;
        case 'photo':
          await _firebaseService.sendModuleData('photos', task.data ?? {});
          break;
        case OfflineSyncQueue.taskNotificationFeedback:
          await _firebaseService.sendNotificationFeedback(task.data ?? {});
          break;
        default:
          if (task.type.startsWith("module:")) {
            final moduleName = task.type.split(":").last;
            await _firebaseService.sendModuleData(moduleName, task.data ?? {});
          } else if (task.type.startsWith("message:")) {
            final convoId = task.type.split(":").last;
            await _firebaseService
                .sendModuleData('messaging/$convoId', task.data ?? {});
          } else if (task.type.startsWith('category:')) {
            final cat = task.type.split(':').last;
            await pushCategoryData(cat, task.data ?? {});
          }
      }
    });

    final photos = await offline_queue.OfflinePhotoQueue.getAllPhotos();
    for (final queued in photos) {
      try {
        await _firebaseService.savePhoto(queued.photo);
      } catch (e) {
        debugPrint('❌ [CloudSync] Erreur envoi photo offline : \$e');
        await offline_queue.OfflinePhotoQueue.addPhoto(queued.photo);
      }
    }
    await offline_queue.OfflinePhotoQueue.clearQueue();

    final gpsBatches = await OfflineGpsQueue.getAllBatches();
    for (final batch in gpsBatches) {
      try {
        final data = batch.points
            .map((p) => {
                  'lat': p.lat,
                  'lon': p.lon,
                  'timestamp': p.timestamp.toIso8601String(),
                })
            .toList();
        await _firebaseService.sendModuleData('gps', {'batch': data});
      } catch (e) {
        debugPrint('❌ [CloudSync] Erreur envoi GPS offline : $e');
        await OfflineGpsQueue.addBatch(batch);
      }
    }
    await OfflineGpsQueue.clearQueue();
  }
}
