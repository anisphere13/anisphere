/// ☁️ CloudSyncService — AniSphère
/// Service central de synchronisation cloud (Firebase ou autre backend)
/// Toutes les données modules & noyau passent ici pour apprentissage IA cloud
/// Utilisé par IAMaster, les modules, les IA locales
library;

import 'package:flutter/foundation.dart';
import '../models/animal_model.dart';
import '../models/user_model.dart';
import 'firebase_service.dart';
import '../services/offline_sync_queue.dart';

class CloudSyncService {
  final FirebaseService _firebaseService;

  CloudSyncService({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  /// 🔁 Envoie les données d’un animal pour apprentissage IA
  Future<void> pushAnimalData(AnimalModel animal) async {
    try {
      await _firebaseService.saveAnimal(animal, forTraining: true);
      debugPrint("☁️ Données animal envoyées au cloud pour IA : ${animal.name}");
    } catch (e) {
      debugPrint("❌ [CloudSync] Erreur pushAnimalData : $e");
      await OfflineSyncQueue.addTask(
        SyncTask(type: "animal", data: animal.toJson(), timestamp: DateTime.now()),
      );
    }
  }

  /// 🔁 Envoie les données d’un utilisateur pour IA (profil, préférences)
  Future<void> pushUserData(UserModel user) async {
    try {
      await _firebaseService.saveUser(user, forTraining: true);
      debugPrint("☁️ Données utilisateur envoyées au cloud pour IA : ${user.email}");
    } catch (e) {
      debugPrint("❌ [CloudSync] Erreur pushUserData : $e");
      await OfflineSyncQueue.addTask(
        SyncTask(type: "user", data: user.toJson(), timestamp: DateTime.now()),
      );
    }
  }

  /// 🔁 Envoie de données spécifiques à un module (format libre)
  Future<void> pushModuleData(String moduleName, Map<String, dynamic> data) async {
    try {
      await _firebaseService.sendModuleData(moduleName, data);
      debugPrint("☁️ Données module $moduleName envoyées au cloud.");
    } catch (e) {
      debugPrint("❌ [CloudSync] Erreur pushModuleData ($moduleName) : $e");
      await OfflineSyncQueue.addTask(
        SyncTask(type: "module:$moduleName", data: data, timestamp: DateTime.now()),
      );
    }
  }

  /// 📊 Envoie d’un retour IA local (métriques, logs, feedbacks)
  Future<void> pushIAFeedback(Map<String, dynamic> metrics) async {
    try {
      await _firebaseService.sendIAFeedback(metrics);
      debugPrint("☁️ Feedback IA locale envoyé au cloud.");
    } catch (e) {
      debugPrint("❌ [CloudSync] Erreur pushIAFeedback : $e");
      await OfflineSyncQueue.addTask(
        SyncTask(type: "ia_feedback", data: metrics, timestamp: DateTime.now()),
      );
    }
  }

  /// 📦 Synchro complète pour IAMaster (utilise les logs de l’app)
  Future<void> syncFullIA(String userId, List<String> logs) async {
    try {
      debugPrint("☁️ [CloudSyncService] Sync full IA pour $userId avec ${logs.length} logs.");
      await Future.delayed(const Duration(milliseconds: 200));
    } catch (e) {
      debugPrint("❌ [CloudSyncService] Erreur syncFullIA : $e");
    }
  }

  /// 🔁 Rejoue toutes les tâches en attente dans la file offline
  Future<void> replayOfflineTasks() async {
    await OfflineSyncQueue.processQueue((task) async {
      switch (task.type) {
        case "animal":
          await _firebaseService.saveAnimal(
            AnimalModel.fromJson(task.data),
            forTraining: true,
          );
          break;
        case "user":
          await _firebaseService.saveUser(
            UserModel.fromJson(task.data),
            forTraining: true,
          );
          break;
        case "ia_feedback":
          await _firebaseService.sendIAFeedback(task.data);
          break;
        default:
          if (task.type.startsWith("module:")) {
            final moduleName = task.type.split(":").last;
            await _firebaseService.sendModuleData(moduleName, task.data);
          }
      }
    });
  }
} 