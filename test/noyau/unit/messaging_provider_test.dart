import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/providers/messaging_provider.dart';
import 'package:anisphere/modules/noyau/models/message_model.dart';
import 'package:anisphere/modules/noyau/services/messaging_service.dart';

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
    await provider.sendMessage('c1', 'u1', 'hi');
    expect(provider.messagesFor('c1').length, 1);
    expect(service.sent.length, 1);
  });
}
