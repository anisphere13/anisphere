library;

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/message_model.dart';
import '../models/conversation_model.dart';
import '../services/messaging_service.dart';

class MessagingProvider with ChangeNotifier {
  final MessagingService _service;
  List<ConversationModel> _conversations = [];
  final Map<String, List<MessageModel>> _messages = {};

  MessagingProvider({MessagingService? service})
      : _service = service ?? MessagingService();

  List<ConversationModel> get conversations => _conversations;

  List<MessageModel> messagesFor(String conversationId) =>
      _messages[conversationId] ?? [];

  Future<void> init() async {
    await _service.init();
    _conversations = await _service.getConversations();
    notifyListeners();
  }

  Future<void> loadMessages(String conversationId) async {
    final msgs = await _service.getMessages(conversationId);
    _messages[conversationId] = msgs;
    notifyListeners();
  }

  Future<void> sendMessage(
    String conversationId,
    String senderId,
    String content,
  ) async {
    final msg = MessageModel(
      id: const Uuid().v4(),
      conversationId: conversationId,
      senderId: senderId,
      content: content,
      createdAt: DateTime.now(),
    );
    await _service.addMessage(msg);
    _messages.putIfAbsent(conversationId, () => []).add(msg);

    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index != -1) {
      final updated = _conversations[index].copyWith(
        lastMessage: content,
        updatedAt: msg.createdAt,
      );
      _conversations[index] = updated;
      await _service.saveConversation(updated);
    }
    notifyListeners();
  }
}
