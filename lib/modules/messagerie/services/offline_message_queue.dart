library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/message_model.dart';

part 'offline_message_queue.g.dart';

@HiveType(typeId: 121)
class QueuedMessage {
  @HiveField(0)
  final MessageModel message;

  @HiveField(1)
  final DateTime timestamp;

  QueuedMessage({required this.message, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}

class OfflineMessageQueue {
  static const String _boxName = 'offline_messages';

  static Future<void> enqueue(MessageModel message) async {
    final box = await Hive.openBox<QueuedMessage>(_boxName);
    await box.add(QueuedMessage(message: message));
    debugPrint('📥 Message ajouté à la file offline : ${message.id}');
  }

  /// New API used by MessagingService
  static Future<void> addMessage(MessageModel msg) => enqueue(msg);

  static Future<List<QueuedMessage>> getAll() async {
    final box = await Hive.openBox<QueuedMessage>(_boxName);
    return box.values.toList();
  }

  /// Returns all queued messages
  static Future<List<QueuedMessage>> getAllMessages() => getAll();

  static Future<void> clear() async {
    final box = await Hive.openBox<QueuedMessage>(_boxName);
    await box.clear();
    debugPrint('🧹 File de messages offline vidée.');
  }

  static Future<void> clearQueue() => clear();
}
