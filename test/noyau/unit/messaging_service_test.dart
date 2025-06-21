import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:hive/hive.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:anisphere/modules/noyau/models/message_model.dart';
import 'package:anisphere/modules/noyau/services/messaging_service.dart';
import 'package:anisphere/modules/noyau/services/offline_message_queue.dart';
import '../../test_config.dart';

void main() {
  late Directory tempDir;
  late FakeFirebaseFirestore firestore;
  late MessagingService service;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(MessageModelAdapter());
    Hive.registerAdapter(QueuedMessageAdapter());
    firestore = FakeFirebaseFirestore();
    service = MessagingService(firestoreInstance: firestore);
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk(MessagingService.boxName);
    await Hive.deleteBoxFromDisk('offline_messages');
    await tempDir.delete(recursive: true);
  });

  test('sendMessage saves and marks message as sent on success', () async {
    final message = MessageModel(
      id: 'm1',
      conversationId: 'c1',
      senderId: 'u1',
      content: 'hello',
    );

    await service.sendMessage(message);
    final msgs = await service.getMessages('c1');

    expect(msgs.length, 1);
    expect(msgs.first.sent, isTrue);
    final doc = await firestore
        .collection('conversations')
        .doc('c1')
        .collection('messages')
        .doc('m1')
        .get();
    expect(doc.data()?['content'], 'hello');
  });
}
