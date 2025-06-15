// Copilot Prompt : Test automatique généré pour consent_provider.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/providers/consent_provider.dart';
import 'package:anisphere/modules/noyau/services/consent_service.dart';
import 'package:anisphere/modules/noyau/models/consent_entry.dart';

class FakeService extends ConsentService {
  List<ConsentEntry> entries = [];
  @override
  Future<List<ConsentEntry>> getHistory() async => entries;
  @override
  Future<void> addEntry(ConsentEntry entry) async {
    entries.add(entry);
  }
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('addAction stores entry in history', () async {
    final provider = ConsentProvider(service: FakeService());
    await provider.addAction(ConsentAction.accepted, 'u1');
    expect(provider.history.length, 1);
    expect(provider.accepted, isTrue);
  });
}
