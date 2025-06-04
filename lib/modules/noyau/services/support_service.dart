/// Copilot Prompt : SupportService AniSphère
/// Gère les retours utilisateurs (bug, idée, contact) avec Hive et Firebase.
/// Sauvegarde locale offline-first, puis envoi cloud via Firebase.

library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/support_model.dart';
import 'firebase_service.dart';
import 'offline_sync_queue.dart';

class SupportService {
  static const String supportBoxName = 'support_data';
  final FirebaseService _firebaseService;
  Box<SupportModel>? _supportBox;
  final bool skipHiveInit;

  SupportService({
    FirebaseService? firebaseService,
    Box<SupportModel>? testBox,
    this.skipHiveInit = false,
  }) : _firebaseService = firebaseService ?? FirebaseService() {
    if (testBox != null) {
      _supportBox = testBox;
    }
  }

  /// 📦 Initialise la boîte Hive pour les retours support
  Future<void> init() async {
    await _initHive();
  }

  Future<void> _initHive() async {
    if (skipHiveInit || _supportBox != null) return;
    try {
      _supportBox = Hive.isBoxOpen(supportBoxName)
          ? Hive.box<SupportModel>(supportBoxName)
          : await Hive.openBox<SupportModel>(supportBoxName);
      _log('📦 Boîte Hive support initialisée.');
    } catch (e) {
      _log('❌ Erreur init Hive support : $e');
    }
  }

  /// 💾 Sauvegarde un feedback localement et sur Firebase
  Future<void> saveFeedback(SupportModel feedback) async {
    try {
      await _initHive();
      await _supportBox?.put(feedback.id, feedback);
      await _firebaseService.db
          .collection('support')
          .doc(feedback.id)
          .set(feedback.toJson(), SetOptions(merge: true));
      _log('✅ Feedback ${feedback.id} sauvegardé.');
    } catch (e) {
      _log('❌ Erreur saveFeedback : $e');
      await OfflineSyncQueue.addTask(
        SyncTask(
          type: 'support',
          data: feedback.toJson(),
          timestamp: DateTime.now(),
        ),
      );
    }
  }

  /// 📚 Récupère tous les feedbacks locaux
  Future<List<SupportModel>> getAllFeedbacks() async {
    try {
      await _initHive();
      return _supportBox?.values.toList() ?? [];
    } catch (e) {
      _log('❌ Erreur getAllFeedbacks : $e');
      return [];
    }
  }

  /// 🗑️ Supprime un feedback localement et sur Firebase
  Future<void> deleteFeedback(String id) async {
    try {
      await _initHive();
      await _supportBox?.delete(id);
      await _firebaseService.db.collection('support').doc(id).delete();
      _log('🗑️ Feedback $id supprimé.');
    } catch (e) {
      _log('❌ Erreur deleteFeedback : $e');
    }
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint('[SupportService] $message');
    }
  }
}
