library;

import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

import '../models/message_model.dart';

part 'offline_message_queue.g.dart';

/// Stores messages that could not be sent immediately.
@HiveType(typeId: 121)
class QueuedMessage {
  @HiveField(0)
  final MessageModel message;

  QueuedMessage({required this.message});
}

class OfflineMessageQueue {
  static const String _boxName = 'offline_message_queue';

  static Future<void> enqueue(MessageModel message) async {
    final box = await Hive.openBox<QueuedMessage>(_boxName);
    await box.add(QueuedMessage(message: message));
    debugPrint('📥 Message mis en attente: ${message.id}');
  }

  static Future<List<MessageModel>> getAll() async {
    final box = await Hive.openBox<QueuedMessage>(_boxName);
    return box.values.map((e) => e.message).toList();
  }

  static Future<void> clear() async {
    final box = await Hive.openBox<QueuedMessage>(_boxName);
    await box.clear();
  }

  static Future<void> process(
    Future<void> Function(MessageModel msg) send,
  ) async {
    final box = await Hive.openBox<QueuedMessage>(_boxName);
    final messages = box.values.toList();
    for (final queued in messages) {
      try {
        await send(queued.message);
      } catch (e) {
        debugPrint('❌ Erreur envoi message offline: $e');
      }
    }
    await clear();
  }
}
