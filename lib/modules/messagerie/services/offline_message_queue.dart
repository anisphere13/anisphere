library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/message_model.dart';

part 'offline_message_queue.g.dart';

/// Model used to store messages waiting to be sent.
@HiveType(typeId: 121)
class QueuedMessage {
  @HiveField(0)
  final MessageModel message;

  const QueuedMessage({required this.message});
}

/// Helper class handling offline message queueing using Hive.
class OfflineMessageQueue {
  static const String _boxName = 'offline_messages';

  /// Add a message to the offline queue.
  static Future<void> enqueue(MessageModel message) async {
    final box = await Hive.openBox<QueuedMessage>(_boxName);
    await box.add(QueuedMessage(message: message));
    debugPrint('📥 Message ajouté à la file offline : ${message.id}');
  }

  /// Retrieve all queued messages.
  static Future<List<MessageModel>> getAll() async {
    final box = await Hive.openBox<QueuedMessage>(_boxName);
    return box.values.map((e) => e.message).toList();
  }

  /// Clear the offline queue.
  static Future<void> clear() async {
    final box = await Hive.openBox<QueuedMessage>(_boxName);
    await box.clear();
    debugPrint('🧹 File de messages offline vidée.');
  }
}
