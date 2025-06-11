library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/message_model.dart';
import '../models/conversation_model.dart';

class MessagingService {
  static const String conversationBoxName = 'conversations';
  static const String messageBoxName = 'messages';

  Box<ConversationModel>? _conversationBox;
  Box<MessageModel>? _messageBox;
  final bool skipHiveInit;

  MessagingService({this.skipHiveInit = false});

  Future<void> init() async {
    await _initHive();
  }

  Future<void> _initHive() async {
    if (skipHiveInit) return;
    if (!Hive.isAdapterRegistered(60)) {
      Hive.registerAdapter(MessageModelAdapter());
    }
    if (!Hive.isAdapterRegistered(61)) {
      Hive.registerAdapter(ConversationModelAdapter());
    }
    _conversationBox = Hive.isBoxOpen(conversationBoxName)
        ? Hive.box<ConversationModel>(conversationBoxName)
        : await Hive.openBox<ConversationModel>(conversationBoxName);
    _messageBox = Hive.isBoxOpen(messageBoxName)
        ? Hive.box<MessageModel>(messageBoxName)
        : await Hive.openBox<MessageModel>(messageBoxName);
  }

  Future<List<ConversationModel>> getConversations() async {
    await _initHive();
    return _conversationBox?.values.toList() ?? [];
  }

  Future<void> saveConversation(ConversationModel conversation) async {
    await _initHive();
    await _conversationBox?.put(conversation.id, conversation);
  }

  Future<List<MessageModel>> getMessages(String conversationId) async {
    await _initHive();
    final all = _messageBox?.values.toList() ?? [];
    return all.where((m) => m.conversationId == conversationId).toList();
  }

  Future<void> addMessage(MessageModel message) async {
    await _initHive();
    await _messageBox?.put(message.id, message);
  }

  void log(String message) {
    if (kDebugMode) {
      debugPrint('[MessagingService] $message');
    }
  }
}
