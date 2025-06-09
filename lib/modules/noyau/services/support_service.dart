// Copilot Prompt : SupportService AniSphère
// Gère les retours utilisateurs (bug, idée, contact) avec Hive et CloudSync.
// Sauvegarde locale offline-first, puis envoi cloud via CloudSyncService.
library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/support_ticket_model.dart';
import 'cloud_sync_service.dart';

class SupportService {
  static const String supportBoxName = 'support_data';
  final CloudSyncService _cloudSyncService;
  Box<SupportTicketModel>? _supportBox;
  final bool skipHiveInit;

  SupportService({
    CloudSyncService? cloudSyncService,
    Box<SupportTicketModel>? testBox,
    this.skipHiveInit = false,
  }) : _cloudSyncService = cloudSyncService ?? CloudSyncService() {
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
          ? Hive.box<SupportTicketModel>(supportBoxName)
          : await Hive.openBox<SupportTicketModel>(supportBoxName);
      _log('📦 Boîte Hive support initialisée.');
    } catch (e) {
      _log('❌ Erreur init Hive support : $e');
    }
  }

  /// 💾 Sauvegarde un feedback localement et via CloudSync
  Future<void> saveFeedback(SupportTicketModel feedback) async {
    try {
      await _initHive();
      await _supportBox?.put(feedback.id, feedback);
      await _cloudSyncService.pushSupportData(feedback);
      _log('✅ Feedback ${feedback.id} sauvegardé.');
    } catch (e) {
      _log('❌ Erreur saveFeedback : $e');
    }
  }

  /// 📚 Récupère tous les feedbacks locaux
  Future<List<SupportTicketModel>> getAllFeedbacks() async {
    try {
      await _initHive();
      return _supportBox?.values.toList() ?? [];
    } catch (e) {
      _log('❌ Erreur getAllFeedbacks : $e');
      return [];
    }
  }

  /// 🗑️ Supprime un feedback localement
  Future<void> deleteFeedback(String id) async {
    try {
      await _initHive();
      await _supportBox?.delete(id);
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