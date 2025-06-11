import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:anisphere/modules/messagerie/models/message_model.dart';
import 'package:anisphere/modules/messagerie/models/message_model.g.dart';
import 'package:anisphere/modules/messagerie/services/messaging_service.dart';
import 'package:anisphere/modules/messagerie/services/offline_message_queue.dart';

import '../../helpers/test_fakes.dart';
import '../../test_config.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    await initTestEnv();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(MessageModelAdapter());
    await Hive.openBox<MessageModel>('messages_box');
    await Hive.openBox<MessageModel>('offline_messages');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('messages_box');
    await Hive.deleteBoxFromDisk('offline_messages');
    await tempDir.delete(recursive: true);
  });

  test('sendMessage writes to Firestore and marks as sent', () async {
    final firestore = FakeFirestore();
    final service = MessagingService(firestoreInstance: firestore);
    final message = MessageModel(
      id: '1',
      conversationId: 'c1',
      senderId: 'u1',
      content: 'hello',
    );

    await service.sendMessage(message);

    final box = Hive.box<MessageModel>('messages_box');
    expect(box.get('1')?.sent, true);
    expect(
      firestore.data['conversations']?['c1']?['messages']?['1']?['content'],
      'hello',
    );
  });

  test('sendMessage failure queues offline', () async {
    final firestore = FakeFirestore(fail: true);
    final service = MessagingService(firestoreInstance: firestore);
    final message = MessageModel(
      id: '2',
      conversationId: 'c2',
      senderId: 'u2',
      content: 'offline',
    );

    await service.sendMessage(message);

    final pending = await OfflineMessageQueue.getAllMessages();
    expect(pending.length, 1);
    expect(pending.first.id, '2');
  });
}
