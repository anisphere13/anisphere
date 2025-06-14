// Copilot Prompt : Test automatique pour consent_service.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/consent_service.dart';
import 'package:anisphere/modules/noyau/models/consent_entry.dart';

class MockBox extends Mock implements Box<ConsentEntry> {}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('addEntry stores entry in Hive box', () async {
    final mockBox = MockBox();
    final service = ConsentService(testBox: mockBox, skipHiveInit: true);

    final entry = ConsentEntry(
      id: 'e1',
      userId: 'u1',
      action: ConsentAction.accepted,
      timestamp: DateTime.now(),
    );

    await service.addEntry(entry);

    verify(mockBox.put('e1', entry)).called(1);
  });
}
