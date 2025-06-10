library;

import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

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

  /// Stores a feedback entry locally.
  static Future<void> addFeedback(String notificationId, bool positive) async {
    final box = await Hive.openBox<NotificationFeedback>(_boxName);
    final entry = NotificationFeedback(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      notificationId: notificationId,
      positive: positive,
      timestamp: DateTime.now(),
    );
    await box.add(entry);
    debugPrint('💬 Feedback enregistré pour $notificationId ($positive)');
  }

  /// Returns all stored feedback entries.
  static Future<List<NotificationFeedback>> getAllFeedback() async {
    final box = await Hive.openBox<NotificationFeedback>(_boxName);
    return box.values.toList();
  }

  /// Clears all stored feedback entries.
  static Future<void> clear() async {
    final box = await Hive.openBox<NotificationFeedback>(_boxName);
    await box.clear();
    debugPrint('🧹 Feedback notifications vidé.');
  }
}
