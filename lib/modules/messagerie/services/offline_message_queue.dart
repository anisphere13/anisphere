library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/message_model.dart';

part 'offline_message_queue.g.dart';

@HiveType(typeId: 121)
class QueuedMessage {
  @HiveField(0)
  final MessageModel message;

  QueuedMessage({required this.message});
}

class OfflineMessageQueue {
  static const String _boxName = 'offline_messages';

  static Future<void> enqueue(MessageModel message) async {
    final box = await Hive.openBox<QueuedMessage>(_boxName);
    await box.add(QueuedMessage(message: message));
    debugPrint('📥 Message ajouté à la file offline : ${message.id}');
  }

  static Future<List<MessageModel>> getAll() async {
    final box = await Hive.openBox<QueuedMessage>(_boxName);
    return box.values.map((e) => e.message).toList();
  }

  static Future<void> clear() async {
    final box = await Hive.openBox<QueuedMessage>(_boxName);
    await box.clear();
    debugPrint('🧹 File de messages offline vidée.');
  }
}
