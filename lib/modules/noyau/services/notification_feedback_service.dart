library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/notification_feedback_model.dart';
import 'cloud_sync_service.dart';
import 'offline_sync_queue.dart';

part 'notification_feedback_service.g.dart';

@HiveType(typeId: 102)
class NotificationFeedback {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String notificationId;

  @HiveField(2)
  final bool positive;

  @HiveField(3)
  final DateTime timestamp;

  NotificationFeedback({
    required this.id,
    required this.notificationId,
    required this.positive,
    required this.timestamp,
  });
}

class NotificationFeedbackService {
  static const String _boxName = 'notification_feedback';

  final CloudSyncService _cloudSyncService;
  Box<NotificationFeedbackModel>? _box;
  final bool skipHiveInit;

  NotificationFeedbackService({
    CloudSyncService? cloudSyncService,
    Box<NotificationFeedbackModel>? testBox,
    this.skipHiveInit = false,
  }) : _cloudSyncService = cloudSyncService ?? CloudSyncService() {
    if (testBox != null) {
      _box = testBox;
    }
  }

  /// --- Static helpers used in unit tests ---
  static Future<void> addFeedback(String notificationId, bool positive) async {
    final box = await Hive.openBox<NotificationFeedback>(_boxName);
    final entry = NotificationFeedback(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      notificationId: notificationId,
      positive: positive,
      timestamp: DateTime.now(),
    );
    await box.add(entry);
    debugPrint('\uD83D\uDCAC Feedback enregistré pour $notificationId ($positive)');
  }

  static Future<List<NotificationFeedback>> getAllFeedback() async {
    final box = await Hive.openBox<NotificationFeedback>(_boxName);
    return box.values.toList();
  }

  static Future<void> clear() async {
    final box = await Hive.openBox<NotificationFeedback>(_boxName);
    await box.clear();
    debugPrint('\uD83E\uDE91 Feedback notifications vidé.');
  }

  Future<void> _initHive() async {
    if (skipHiveInit || _box != null) return;
    if (!Hive.isAdapterRegistered(24)) {
      Hive.registerAdapter(NotificationFeedbackModelAdapter());
    }
    _box = Hive.isBoxOpen(_boxName)
        ? Hive.box<NotificationFeedbackModel>(_boxName)
        : await Hive.openBox<NotificationFeedbackModel>(_boxName);
  }

  Future<void> saveFeedback(NotificationFeedbackModel feedback) async {
    try {
      await _initHive();
      await _box?.add(feedback);
      await _cloudSyncService.pushNotificationFeedback(feedback);
      _log('Feedback enregistré');
    } catch (e) {
      await OfflineSyncQueue.addTask(SyncTask(
        type: OfflineSyncQueue.taskNotificationFeedback,
        data: feedback.toJson(),
        timestamp: DateTime.now(),
      ));
      _log('Erreur saveFeedback : $e');
    }
  }

  Future<List<NotificationFeedbackModel>> getAllFeedbacks() async {
    try {
      await _initHive();
      return _box?.values.toList() ?? [];
    } catch (e) {
      _log('Erreur getAllFeedbacks : $e');
      return [];
    }
  }

  Future<void> clearBox() async {
    try {
      await _initHive();
      await _box?.clear();
    } catch (e) {
      _log('Erreur clear : $e');
    }
  }

  void _log(String msg) {
    if (kDebugMode) {
      debugPrint('[NotificationFeedbackService] $msg');
    }
  }
}
