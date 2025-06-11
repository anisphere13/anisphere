library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/message_model.dart';

class OfflineMessageQueue {
  static const String _boxName = 'offline_messages';

  static Future<void> addMessage(MessageModel message) async {
    final box = await Hive.openBox<MessageModel>(_boxName);
    await box.add(message);
    debugPrint('📥 Message ajouté à la file offline : ${message.id}');
  }

  static Future<List<MessageModel>> getAllMessages() async {
    final box = await Hive.openBox<MessageModel>(_boxName);
    return box.values.toList();
  }

  static Future<void> clearQueue() async {
    final box = await Hive.openBox<MessageModel>(_boxName);
    await box.clear();
    debugPrint('🧹 File de messages offline vidée.');
  }
}
