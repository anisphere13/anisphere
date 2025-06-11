import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/messagerie/providers/messaging_provider.dart';
import 'package:anisphere/modules/messagerie/models/message_model.dart';
import 'package:anisphere/modules/messagerie/services/messaging_service.dart';

class _FakeService extends MessagingService {
  List<MessageModel> sent = [];
  _FakeService();
  @override
  Future<void> sendMessage(MessageModel message) async {
    sent.add(message);
  }

  @override
  Future<List<MessageModel>> getMessages(String conversationId) async {
    return sent.where((m) => m.conversationId == conversationId).toList();
  }
}

void main() {
  test('send adds message to conversation and delegates to service', () async {
    final service = _FakeService();
    final provider = MessagingProvider(service: service);
    final msg = MessageModel(
      id: '1',
      conversationId: 'c1',
      senderId: 'u1',
      receiverId: 'u2',
      content: 'hi',
      timestamp: DateTime.now(),
    );

    await provider.send(msg);
    expect(provider.getMessages('c1').length, 1);
    expect(service.sent.length, 1);
  });
}
