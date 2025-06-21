import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/notification_feedback_service.dart';
import 'package:anisphere/modules/noyau/services/cloud_sync_service.dart';
import 'package:anisphere/modules/noyau/models/notification_feedback_model.dart';

class MockBox extends Mock implements Box<NotificationFeedbackModel> {}
class MockCloudSyncService extends Mock implements CloudSyncService {}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('saveFeedback stores entry and pushes to cloud', () async {
    final mockBox = MockBox();
    final mockCloud = MockCloudSyncService();
    final service = NotificationFeedbackService(
      cloudSyncService: mockCloud,
      testBox: mockBox,
      skipHiveInit: true,
    );

    final feedback = NotificationFeedbackModel(
      notificationId: 'n1',
      userId: 'u1',
      openedAt: DateTime.now(),
      reaction: 'ok',
      module: 'core',
      type: 'info',
      createdAt: DateTime.now(),
    );

    await service.saveFeedback(feedback);

    verify(mockBox.add(feedback)).called(1);
    verify(mockCloud.pushNotificationFeedback(feedback)).called(1);
  });
}
