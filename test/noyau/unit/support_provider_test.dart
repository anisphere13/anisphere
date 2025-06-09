// Copilot Prompt : Test automatique généré pour support_provider.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/providers/support_provider.dart';
import 'package:anisphere/modules/noyau/services/support_service.dart';
import 'package:anisphere/modules/noyau/services/cloud_sync_service.dart';
import 'package:anisphere/modules/noyau/models/support_ticket_model.dart';

class MockBox extends Mock implements Box<SupportTicketModel> {}

class MockCloudSyncService extends Mock implements CloudSyncService {}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('addFeedback delegates to SupportService', () async {
    final mockBox = MockBox();
    final mockCloud = MockCloudSyncService();
    final service = SupportService(
      cloudSyncService: mockCloud,
      testBox: mockBox,
      skipHiveInit: true,
    );
    final provider = SupportProvider(service: service);

    final feedback = SupportTicketModel(
      id: 'f1',
      userId: 'u1',
      type: SupportTicketType.bug,
      message: 'msg',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await provider.addFeedback(feedback);

    verify(mockBox.put('f1', feedback)).called(1);
    verify(mockCloud.pushSupportData(feedback)).called(1);
    expect(provider.feedbacks.length, 1);
  });
}
