// Copilot Prompt : IASyncService AniSphère.
// Détecte automatiquement les événements importants (ajout animal, update, module actif),
// Vérifie si l’utilisateur est premium et déclenche la synchronisation IA cloud.
// Optimisé sans coût : batch, différé, sans doublon, sans surcharge.
// Utilise CloudSyncService en arrière-plan. Journalise localement via IALogger.


import 'package:flutter/foundation.dart';

import '../models/animal_model.dart';
import '../models/user_model.dart';
import '../logic/ia_flag.dart';
import '../logic/ia_logger.dart';
import '../logic/ia_channel.dart'; // <-- Import l'enum ici
import 'cloud_sync_service.dart';

class IASyncService {
  static final IASyncService instance = IASyncService._internal();

  final CloudSyncService _cloudSync = CloudSyncService();
  final List<String> _syncedAnimalIds = [];

  IASyncService._internal();

  /// 🔁 Synchro automatique à l’ajout ou modification d’un animal
  Future<void> syncAnimal(AnimalModel animal, UserModel user) async {
    if (!user.iaPremium || IAFlag.offlineOnly) return;

    try {
      if (_syncedAnimalIds.contains(animal.id)) return;

      await _cloudSync.pushAnimalData(animal);
      _syncedAnimalIds.add(animal.id);
      await IALogger.log(
        channel: IAChannel.sync,
        message: "Animal ${animal.name} synchronisé avec le cloud IA.",
      );
    } catch (e) {
      _logError("Erreur de sync animal ${animal.name}", e);
    }
  }

  /// 🔁 Synchro automatique du profil utilisateur (au login ou changement)
  Future<void> syncUser(UserModel user) async {
    if (!user.iaPremium || IAFlag.offlineOnly) return;

    try {
      await _cloudSync.pushUserData(user);
      await IALogger.log(
        channel: IAChannel.sync,
        message: "Utilisateur ${user.email} synchronisé avec le cloud IA.",
      );
    } catch (e) {
      _logError("Erreur de sync utilisateur ${user.email}", e);
    }
  }

  /// 🔁 Synchro de module spécifique
  Future<void> syncModuleData({
    required String moduleName,
    required Map<String, dynamic> data,
    required UserModel user,
  }) async {
    if (!user.iaPremium || IAFlag.offlineOnly) return;

    try {
      await _cloudSync.pushModuleData(moduleName, data);
      await IALogger.log(
        channel: IAChannel.sync,
        message: "Données module $moduleName synchronisées avec le cloud IA.",
      );
    } catch (e) {
      _logError("Erreur de sync module $moduleName", e);
    }
  }

  /// 🔁 Synchro de feedback IA locale (suggestions, règles, etc.)
  Future<void> syncFeedback(
      Map<String, dynamic> feedback, UserModel user) async {
    if (!user.iaPremium || IAFlag.offlineOnly) return;

    try {
      await _cloudSync.pushIAFeedback(feedback);
      await IALogger.log(
        channel: IAChannel.sync,
        message: "Feedback IA locale envoyé avec succès.",
      );
    } catch (e) {
      _logError("Erreur feedback IA", e);
    }
  }

  /// Log d'erreur typé, visible uniquement en debug.
  void _logError(String prefix, dynamic error) {
    assert(() {
      debugPrint("❌ $prefix : $error");
      return true;
    }());
  }
}
