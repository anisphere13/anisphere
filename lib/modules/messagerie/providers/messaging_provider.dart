library;

import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../services/messaging_service.dart';

/// Provider managing active conversations and new message notifications.
class MessagingProvider extends ChangeNotifier {
  final MessagingService _service;
  final Map<String, List<MessageModel>> _conversations = {};

  MessagingProvider({MessagingService? service})
      : _service = service ?? MessagingService();

  List<MessageModel> getMessages(String conversationId) =>
      _conversations[conversationId] ?? [];

  Future<void> loadConversation(String conversationId) async {
    final msgs = await _service.getMessages(conversationId);
    _conversations[conversationId] = msgs;
    notifyListeners();
  }

  Future<void> send(MessageModel message) async {
    await _service.sendMessage(message);
    _conversations.putIfAbsent(message.conversationId, () => []);
    _conversations[message.conversationId]!.add(message);
    notifyListeners();
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
