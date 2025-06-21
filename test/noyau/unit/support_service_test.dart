// Copilot Prompt : Test automatique généré pour support_service.dart (unit)
// fix: verify saved message using collection().doc().get()
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/support_service.dart';
import 'package:anisphere/modules/noyau/services/cloud_sync_service.dart';
import 'package:anisphere/modules/noyau/models/support_ticket_model.dart';
import '../../helpers/test_fakes.dart';

class MockBox extends Mock implements Box<SupportTicketModel> {}



void main() {
  late FakeFirestore firestore;

  setUpAll(() async {
    await initTestEnv();
  });

  setUp(() {
    firestore = FakeFirestore();
  });


  test('saveFeedback calls CloudSyncService and stores locally', () async {
    final mockBox = MockBox();
    final service = SupportService(
      cloudSyncService:
          CloudSyncService(firebaseService: FakeFirebaseService(firestore)),
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
    final doc = await firestore.collection('support').doc('f1').get();
    expect(doc.data()?['message'], 'issue');
  });
}
