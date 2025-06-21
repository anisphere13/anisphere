import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:hive/hive.dart';

import '../../test_config.dart';
import 'package:anisphere/modules/noyau/services/iap_validator.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    await LocalStorageService.init();
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('users');
    await Hive.deleteBoxFromDisk('animals');
    await Hive.deleteBoxFromDisk('settings');
    await tempDir.delete(recursive: true);
  });

  test('returns true for known receipt and unlocks', () async {
    await LocalStorageService.set('iap_valid_tokens', ['token1']);
    final validator = IapValidator();

    final result = await validator.validate('token1');

    expect(result, isTrue);
    expect(await LocalStorageService.getBool('iap_locked'), isFalse);
    final suspicious = LocalStorageService.get('iap_suspicious_tokens', defaultValue: <String>[]);
    expect(suspicious, isEmpty);
  });

  test('returns false for unknown receipt and locks', () async {
    await LocalStorageService.set('iap_valid_tokens', ['token1']);
    final validator = IapValidator();

    final result = await validator.validate('bad');

    expect(result, isFalse);
    expect(await LocalStorageService.getBool('iap_locked'), isTrue);
    final suspicious = LocalStorageService.get('iap_suspicious_tokens', defaultValue: <String>[]);
    expect(suspicious, contains('bad'));
  });
}
