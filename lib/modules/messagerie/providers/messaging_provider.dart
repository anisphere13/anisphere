library;

import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../models/conversation_model.dart';
import '../services/messaging_service.dart';

/// Provider managing active conversations and new message notifications.
class MessagingProvider extends ChangeNotifier {
  final MessagingService _service;
  final List<ConversationModel> _conversations = [];
  final Map<String, List<MessageModel>> _messages = {};

  MessagingProvider({MessagingService? service})
      : _service = service ?? MessagingService();

  List<ConversationModel> get conversations => List.unmodifiable(_conversations);

  Future<void> init() async {
    for (final conv in _conversations) {
      await loadMessages(conv.id);
    }
  }

  List<MessageModel> messagesFor(String id) => _messages[id] ?? [];

  Future<void> loadMessages(String conversationId) async {
    final msgs = await _service.getMessages(conversationId);
    _messages[conversationId] = msgs;
    notifyListeners();
  }

  Future<MessageModel> sendMessage(
      String conversationId, String senderId, String text) async {
    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: conversationId,
      senderId: senderId,
      receiverId: '',
      content: text,
      timestamp: DateTime.now(),
    );
    await _service.sendMessage(message);
    _messages.putIfAbsent(conversationId, () => []).add(message);

    final idx = _conversations.indexWhere((c) => c.id == conversationId);
    if (idx != -1) {
      _conversations[idx] = _conversations[idx].copyWith(
        lastMessage: text,
        lastTimestamp: DateTime.now(),
      );
    }
    notifyListeners();
    return message;
  }

  Future<void> refresh(List<String> conversationIds) async {
    for (final id in conversationIds) {
      await loadMessages(id);
    }
  }

  Future<void> syncOffline() async {
    await _service.syncOfflineMessages();
  }
}
