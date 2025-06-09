import 'dart:io';
=======
// Copilot Prompt : Test automatique généré pour support_service.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/support_service.dart';
import 'package:anisphere/modules/noyau/services/cloud_sync_service.dart';
import 'package:anisphere/modules/noyau/models/support_ticket_model.dart';

class MockBox extends Mock implements Box<SupportTicketModel> {}

class MockCloudSyncService extends Mock implements CloudSyncService {}
>>>>>>> codex/refactor-supportservice-pour-utiliser-cloudsyncservice

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/models/support_ticket_model.dart';
import 'package:anisphere/modules/noyau/services/support_service.dart';
import 'package:anisphere/modules/noyau/services/offline_sync_queue.dart';

import '../../helpers/test_fakes.dart';
void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(SupportTicketModelAdapter());
    Hive.registerAdapter(SupportTicketTypeAdapter());
    Hive.registerAdapter(SupportTicketStatusAdapter());
    Hive.registerAdapter(SyncTaskAdapter());
    await Hive.openBox<SupportTicketModel>('support_data');
    await Hive.openBox<SyncTask>('offline_sync_queue');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('support_data');
    await Hive.deleteBoxFromDisk('offline_sync_queue');
    await tempDir.delete(recursive: true);
  });

  test('saveFeedback stores ticket locally and remotely', () async {
    final firestore = FakeFirestore();
    final service = SupportService(
      firebaseService: FakeFirebaseService(firestore),
      skipHiveInit: true,
      testBox: Hive.box<SupportTicketModel>('support_data'),
    );
    final ticket = SupportTicketModel(
      id: '1',
      userId: 'u1',
      type: 'bug',
      message: 'msg',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await service.saveFeedback(ticket);
    final box = Hive.box<SupportTicketModel>('support_data');
    expect(box.get('1')?.message, 'msg');
    expect(firestore.data['support']?['1']?['message'], 'msg');
  });

  test('saveFeedback queues ticket when Firebase fails', () async {
    final firestore = FakeFirestore(fail: true);
    final service = SupportService(
      firebaseService: FakeFirebaseService(firestore),
      skipHiveInit: true,
      testBox: Hive.box<SupportTicketModel>('support_data'),
    );
    final queueBox = Hive.box<SyncTask>('offline_sync_queue');
    final ticket = SupportTicketModel(
      id: '2',
      userId: 'u2',
      type: 'bug',
      message: 'err',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await service.saveFeedback(ticket);
    expect(queueBox.length, 1);
    expect(queueBox.getAt(0)?.data['message'], 'err');
=======
  test('saveFeedback calls CloudSyncService and stores locally', () async {
    final mockBox = MockBox();
    final mockCloud = MockCloudSyncService();
    final service = SupportService(
      cloudSyncService: mockCloud,
      testBox: mockBox,
      skipHiveInit: true,
    );

    final feedback = SupportTicketModel(
      id: 'f1',
      userId: 'u1',
      type: 'bug',
      message: 'issue',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await service.saveFeedback(feedback);

    verify(mockBox.put('f1', feedback)).called(1);
    verify(mockCloud.pushSupportData(feedback)).called(1);
>>>>>>> codex/refactor-supportservice-pour-utiliser-cloudsyncservice
  });
}
