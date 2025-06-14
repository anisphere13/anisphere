import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:anisphere/modules/noyau/services/consent_service.dart';
import '../../test_config.dart';

void main() {
  const keyName = 'hive_aes_key';
  const secureStorage = FlutterSecureStorage();
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    await secureStorage.delete(key: keyName);
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('consents');
    await tempDir.delete(recursive: true);
    await secureStorage.delete(key: keyName);
  });

  test('record and revoke consent', () async {
    await ConsentService.recordConsent('gps', 'noyau', '1.0', 'location');
    final has = await ConsentService.hasConsent('gps', 'noyau');
    expect(has, isTrue);

    var box = await Hive.openBox('consents');
    expect(box.length, 1);

    await ConsentService.revokeConsent('gps', 'noyau');
    final hasAfter = await ConsentService.hasConsent('gps', 'noyau');
    expect(hasAfter, isFalse);
    box = await Hive.openBox('consents');
    expect(box.isEmpty, true);
  });
}
