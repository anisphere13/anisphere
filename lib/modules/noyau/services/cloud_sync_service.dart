/// ☁️ CloudSyncService — AniSphère
/// Service central de synchronisation cloud (Firebase ou autre backend)
/// Toutes les données modules & noyau passent ici pour apprentissage IA cloud
/// Utilisé par IAMaster, les modules, les IA locales
library;

import 'package:flutter/foundation.dart';
import '../models/animal_model.dart';
import '../models/user_model.dart';
import 'firebase_service.dart';
import 'local_storage_service.dart';
import '../services/animal_service.dart';
import '../services/user_service.dart';

class CloudSyncService {
  final FirebaseService _firebaseService;

  CloudSyncService({FirebaseService? firebaseService})
      : _firebaseService = firebaseService ?? FirebaseService();

  /// 🔁 Envoie les données d’un animal pour apprentissage IA
  Future<void> pushAnimalData(AnimalModel animal) async {
    try {
      await _firebaseService.saveAnimal(animal, forTraining: true);
      debugPrint("☁️ Données animal envoyées au cloud pour IA : \${animal.name}");
    } catch (e) {
      debugPrint("❌ [CloudSync] Erreur pushAnimalData : \$e");
    }
  }

  /// 🔁 Envoie les données d’un utilisateur pour IA (profil, préférences)
  Future<void> pushUserData(UserModel user) async {
    try {
      await _firebaseService.saveUser(user, forTraining: true);
      debugPrint("☁️ Données utilisateur envoyées au cloud pour IA : \${user.email}");
    } catch (e) {
      debugPrint("❌ [CloudSync] Erreur pushUserData : \$e");
    }
  }

  /// 🔁 Envoie de données spécifiques à un module (format libre)
  Future<void> pushModuleData(String moduleName, Map<String, dynamic> data) async {
    try {
      await _firebaseService.sendModuleData(moduleName, data);
      debugPrint("☁️ Données module \$moduleName envoyées au cloud.");
    } catch (e) {
      debugPrint("❌ [CloudSync] Erreur pushModuleData (\$moduleName) : \$e");
    }
  }

  /// 📊 Envoie d’un retour IA local (métriques, logs, feedbacks)
  Future<void> pushIAFeedback(Map<String, dynamic> metrics) async {
    try {
      await _firebaseService.sendIAFeedback(metrics);
      debugPrint("☁️ Feedback IA locale envoyé au cloud.");
    } catch (e) {
      debugPrint("❌ [CloudSync] Erreur pushIAFeedback : \$e");
    }
  }

  /// 📦 Synchro complète pour IAMaster (utilise les logs de l’app)
  Future<void> syncFullIA(String userId, List<String> logs) async {
    try {
      debugPrint("☁️ [CloudSyncService] Sync full IA pour $userId avec ${logs.length} logs.");
      // TODO : upload les logs ou autres données vers Firebase ou autre backend ici si besoin
      await Future.delayed(const Duration(milliseconds: 200));
      // Tu peux ajouter ici une future vraie logique d’envoi cloud.
    } catch (e) {
      debugPrint("❌ [CloudSyncService] Erreur syncFullIA : $e");
    }
  }

}
