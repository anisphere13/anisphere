import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/models/message_model.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
    Hive.registerAdapter(MessageModelAdapter());
  });

  test('fromJson/toJson round trip', () {
    final now = DateTime.now();
    final message = MessageModel(
      id: 'm1',
      conversationId: 'c1',
      senderId: 'u1',
      receiverId: 'u2',
      content: 'hello',
      timestamp: now,
      sent: true,
      moduleContext: 'core',
      priority: 1,
      status: 'sent',
    );

    final json = message.toJson();
    final from = MessageModel.fromJson(json);

    expect(from.id, message.id);
    expect(from.conversationId, message.conversationId);
    expect(from.senderId, message.senderId);
    expect(from.receiverId, message.receiverId);
    expect(from.content, message.content);
    expect(from.timestamp.toIso8601String(), message.timestamp.toIso8601String());
    expect(from.sent, message.sent);
    expect(from.moduleContext, message.moduleContext);
    expect(from.priority, message.priority);
    expect(from.status, message.status);
  });

  test('copyWith updates values', () {
    final message = MessageModel(
      id: 'm1',
      conversationId: 'c1',
      senderId: 'u1',
      content: 'hello',
    );

    final copy = message.copyWith(content: 'hi', sent: true);

    expect(copy.id, message.id);
    expect(copy.conversationId, message.conversationId);
    expect(copy.senderId, message.senderId);
    expect(copy.receiverId, message.receiverId);
    expect(copy.content, 'hi');
    expect(copy.sent, true);
  });
}
