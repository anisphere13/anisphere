import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/messagerie/models/message_model.dart';
import 'package:anisphere/modules/messagerie/services/messaging_service.dart';
import 'package:anisphere/modules/messagerie/services/offline_message_queue.dart';

import '../../test_config.dart';
import '../../helpers/test_fakes.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('sendMessage stores message locally and queues on failure', () async {
    final tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(MessageModelAdapter());
    Hive.registerAdapter(QueuedMessageAdapter());

    final service = MessagingService(firestoreInstance: FakeFirestore(fail: true));
    final message = MessageModel(
      id: '1',
      conversationId: 'c1',
      senderId: 'u1',
      content: 'hello',
    );

    await service.sendMessage(message);

    final box = await Hive.openBox<MessageModel>('messages_box');
    expect(box.get('1')?.content, 'hello');
    final queued = await OfflineMessageQueue.getAll();
    expect(queued.length, 1);
    expect(queued.first.message.content, 'hello');

    await tempDir.delete(recursive: true);
  });
}
