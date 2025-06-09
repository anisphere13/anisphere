import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/support_service.dart';
import 'package:anisphere/modules/noyau/services/cloud_sync_service.dart';
import 'package:anisphere/modules/noyau/services/offline_sync_queue.dart';
import 'package:anisphere/modules/noyau/models/support_ticket_model.dart';

class MockCloudSyncService extends Mock implements CloudSyncService {}

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
  test('saveFeedback stores ticket locally and calls CloudSyncService', () async {
    final box = Hive.box<SupportTicketModel>('support_data');
    final mockCloud = MockCloudSyncService();
    final service = SupportService(
      cloudSyncService: mockCloud,
      testBox: box,
      skipHiveInit: true,
    );

    final feedback = SupportTicketModel(
      id: 'f1',
      userId: 'u1',
      type: SupportTicketType.bug,
      message: 'issue',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await service.saveFeedback(feedback);

    expect(box.get('f1')?.message, 'issue');
    verify(mockCloud.pushSupportData(feedback)).called(1);
  });

  test('saveFeedback queues ticket when CloudSyncService throws', () async {
    final box = Hive.box<SupportTicketModel>('support_data');
    final mockCloud = MockCloudSyncService();
    when(mockCloud.pushSupportData(any)).thenThrow(Exception('fail'));
    final service = SupportService(
      cloudSyncService: mockCloud,
      testBox: box,
      skipHiveInit: true,
    );
    final queueBox = Hive.box<SyncTask>('offline_sync_queue');


    final ticket = SupportTicketModel(
      id: 'f2',
      userId: 'u2',
      type: SupportTicketType.bug,
      message: 'err',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await service.saveFeedback(ticket);

    expect(queueBox.length, 1);
    expect(queueBox.getAt(0)?.data['message'], 'err');
  });
}
