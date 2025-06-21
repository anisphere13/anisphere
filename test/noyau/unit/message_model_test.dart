import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/models/message_model.dart';

import '../../test_config.dart';

@Skip('Temporarily disabled')
void main() {
  late Directory tempDir;

  setUpAll(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive
      ..init(tempDir.path)
      ..registerAdapter(MessageModelAdapter());
  });

  tearDownAll(() async {
    await tempDir.delete(recursive: true);
  });

  test('fromJson parses all fields', () {
    final data = {
      'id': 'm1',
      'conversationId': 'c1',
      'senderId': 's1',
      'receiverId': 'r1',
      'content': 'Hello',
      'timestamp': '2024-01-01T12:00:00.000',
      'sent': true,
      'moduleContext': 'chat',
      'priority': 2,
      'status': 'read',
    };
    final msg = MessageModel.fromJson(data);

    expect(msg.id, 'm1');
    expect(msg.conversationId, 'c1');
    expect(msg.senderId, 's1');
    expect(msg.receiverId, 'r1');
    expect(msg.content, 'Hello');
    expect(msg.timestamp.toIso8601String(), '2024-01-01T12:00:00.000');
    expect(msg.sent, isTrue);
    expect(msg.moduleContext, 'chat');
    expect(msg.priority, 2);
    expect(msg.status, 'read');
  });

  test('toJson/fromJson round trip', () {
    final original = MessageModel(
      id: 'm2',
      conversationId: 'c2',
      senderId: 's2',
      receiverId: 'r2',
      content: 'Hi',
      timestamp: DateTime(2023, 5, 10, 8, 0),
      sent: false,
      moduleContext: 'training',
      priority: 1,
      status: 'pending',
    );
    final json = original.toJson();
    final copy = MessageModel.fromJson(json);

    expect(copy.id, original.id);
    expect(copy.conversationId, original.conversationId);
    expect(copy.senderId, original.senderId);
    expect(copy.receiverId, original.receiverId);
    expect(copy.content, original.content);
    expect(copy.timestamp.toIso8601String(), original.timestamp.toIso8601String());
    expect(copy.sent, original.sent);
    expect(copy.moduleContext, original.moduleContext);
    expect(copy.priority, original.priority);
    expect(copy.status, original.status);
  });

  test('copyWith updates fields correctly', () {
    final msg = MessageModel(
      id: 'm3',
      conversationId: 'c3',
      senderId: 's3',
      receiverId: 'r3',
      content: 'Old',
      timestamp: DateTime(2024, 6, 1),
      sent: false,
      moduleContext: 'demo',
      priority: 0,
      status: '',
    );
    final updated = msg.copyWith(content: 'Updated', sent: true);

    expect(updated.id, msg.id);
    expect(updated.conversationId, msg.conversationId);
    expect(updated.senderId, msg.senderId);
    expect(updated.receiverId, msg.receiverId);
    expect(updated.timestamp, msg.timestamp);
    expect(updated.moduleContext, msg.moduleContext);
    expect(updated.priority, msg.priority);
    expect(updated.status, msg.status);
    expect(updated.content, 'Updated');
    expect(updated.sent, isTrue);
  });
}
