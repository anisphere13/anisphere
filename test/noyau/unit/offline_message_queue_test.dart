import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/models/message_model.dart';
import 'package:anisphere/modules/noyau/services/offline_message_queue.dart';
import '../../test_config.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(MessageModelAdapter());
    Hive.registerAdapter(QueuedMessageAdapter());
    await Hive.openBox<QueuedMessage>('offline_messages');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('offline_messages');
    await tempDir.delete(recursive: true);
  });

  test('addMessage stores message in Hive box', () async {
    final msg = MessageModel(
      id: 'm1',
      conversationId: 'c1',
      senderId: 'u1',
      content: 'hello',
    );

    await OfflineMessageQueue.addMessage(msg);
    final box = await Hive.openBox<QueuedMessage>('offline_messages');
    expect(box.length, 1);
    expect(box.getAt(0)?.message.id, 'm1');
  });

  test('clearQueue removes all messages', () async {
    final msg = MessageModel(
      id: 'm2',
      conversationId: 'c1',
      senderId: 'u1',
      content: 'hi',
    );
    await OfflineMessageQueue.addMessage(msg);
    await OfflineMessageQueue.clearQueue();
    final box = await Hive.openBox<QueuedMessage>('offline_messages');
    expect(box.isEmpty, true);
  });
}
