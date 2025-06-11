library;

import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../models/conversation_model.dart';
import '../services/messaging_service.dart';

/// Provider managing active conversations and new message notifications.
class MessagingProvider extends ChangeNotifier {
  final MessagingService _service;
  final Map<String, List<MessageModel>> _conversations = {};
  final List<ConversationModel> _conversationList = [];

  MessagingProvider({MessagingService? service})
      : _service = service ?? MessagingService();

  Future<void> init() async {
    // placeholder for future initialisation
  }

  List<ConversationModel> get conversations => _conversationList;

  List<MessageModel> getMessages(String conversationId) =>
      _conversations[conversationId] ?? [];

  List<MessageModel> messagesFor(String conversationId) => getMessages(conversationId);

  Future<void> loadConversation(String conversationId) async {
    final msgs = await _service.getMessages(conversationId);
    _conversations[conversationId] = msgs;
    notifyListeners();
  }

  Future<void> loadMessages(String conversationId) => loadConversation(conversationId);

  Future<void> send(MessageModel message) async {
    await _service.sendMessage(message);
    _conversations.putIfAbsent(message.conversationId, () => []);
    _conversations[message.conversationId]!.add(message);
    notifyListeners();
  }

  Future<void> sendMessage(
      String conversationId, String senderId, String content) async {
    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: conversationId,
      senderId: senderId,
      receiverId: '',
      content: content,
      timestamp: DateTime.now(),
    );
    await send(message);
  }

  Future<void> refresh(List<String> conversationIds) async {
    for (final id in conversationIds) {
      await loadConversation(id);
    }
  }

  Future<void> syncOffline() async {
    await _service.syncOfflineMessages();
  }
}
