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


void main() {
  setUpAll(() async {
    await initTestEnv();
    expect(firestore.data['support']?['1']?['message'], 'msg');
  });


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
      type: SupportTicketType.bug,
      message: 'issue',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await service.saveFeedback(feedback);

    verify(mockBox.put('f1', feedback)).called(1);
    verify(mockCloud.pushSupportData(feedback)).called(1);
  });
}
