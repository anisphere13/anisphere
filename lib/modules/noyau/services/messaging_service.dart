library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/message_model.dart';
import 'offline_message_queue.dart';

/// Service handling messages storage and synchronization.
class MessagingService {
  static const String boxName = 'messages_box';

  final FirebaseFirestore firestore;
  Box<MessageModel>? _box;

  MessagingService({FirebaseFirestore? firestoreInstance})
      : firestore = firestoreInstance ?? FirebaseFirestore.instance;

  Future<void> _initHive() async {
    if (_box != null) return;
    if (!Hive.isAdapterRegistered(70)) {
      Hive.registerAdapter(MessageModelAdapter());
    }
    if (!Hive.isAdapterRegistered(121)) {
      Hive.registerAdapter(QueuedMessageAdapter());
    }
    _box = Hive.isBoxOpen(boxName)
        ? Hive.box<MessageModel>(boxName)
        : await Hive.openBox<MessageModel>(boxName);
  }

  Future<void> sendMessage(MessageModel message) async {
    await _initHive();
    await _box?.put(message.id, message);
    try {
      await firestore
          .collection('conversations')
          .doc(message.conversationId)
          .collection('messages')
          .doc(message.id)
          .set(message.toMap());
      await _box?.put(message.id, message.copyWith(sent: true));
    } catch (e) {
      debugPrint('❌ Envoi Firestore échoué, mise en queue.');
      await OfflineMessageQueue.addMessage(message);
    }
  }

  Future<List<MessageModel>> getMessages(String conversationId) async {
    await _initHive();
    return _box?.values
            .where((m) => m.conversationId == conversationId)
            .toList() ??
        [];
  }

  Future<void> syncOfflineMessages() async {
    await _initHive();
    final pending = await OfflineMessageQueue.getAllMessages();
    if (pending.isEmpty) return;
    final batch = firestore.batch();
    for (final queued in pending) {
      final msg = queued.message;
      final ref = firestore
          .collection('conversations')
          .doc(msg.conversationId)
          .collection('messages')
          .doc(msg.id);
      batch.set(ref, msg.toMap(), SetOptions(merge: true));
    }
    try {
      await batch.commit();
      for (final queued in pending) {
        final msg = queued.message;
        await _box?.put(msg.id, msg.copyWith(sent: true));
      }
      await OfflineMessageQueue.clearQueue();
    } catch (e) {
      debugPrint('❌ Batch sync failed: $e');
    }
  }
}
