// Copilot Prompt : Test automatique généré pour consent_service.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/consent_service.dart';
import 'package:anisphere/modules/noyau/models/consent_entry.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('saveConsent persists acceptance', () async {
    final dir = await Directory.systemTemp.createTemp();
    Hive.init(dir.path);
    Hive.registerAdapter(ConsentActionAdapter());
    Hive.registerAdapter(ConsentEntryAdapter());
    final service = ConsentService();
    await service.saveConsent('terms');
    final result = await service.hasConsent('terms');
    expect(result, isTrue);
    await Hive.deleteBoxFromDisk('consent_history');
    await dir.delete(recursive: true);
  });
}
