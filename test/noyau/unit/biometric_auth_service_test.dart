import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/biometric_auth_service.dart';
import 'package:anisphere/modules/noyau/models/security_settings_model.dart';
import '../../test_config.dart';

void main() {
  const channel = MethodChannel('plugins.flutter.io/local_auth');
  final List<MethodCall> log = [];
  late Directory tempDir;
  late Box<SecuritySettingsModel> box;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive
      ..init(tempDir.path)
      ..registerAdapter(SecuritySettingsModelAdapter());
    box = await Hive.openBox<SecuritySettingsModel>('securitySettings');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
      log.add(call);
      if (call.method == 'authenticate') return true;
      if (call.method == 'getAvailableBiometrics') return ['fingerprint'];
      if (call.method == 'isDeviceSupported') return true;
      return true;
    });
  });

  tearDown(() async {
    await box.close();
    await Hive.deleteBoxFromDisk('securitySettings');
    await tempDir.delete(recursive: true);
    log.clear();
  });

  test('canCheckBiometrics returns true', () async {
    final service = BiometricAuthService();
    expect(await service.canCheckBiometrics(), isTrue);
    expect(log.any((c) => c.method == 'isDeviceSupported'), isTrue);
  });

  test('authenticateWithBiometrics succeeds', () async {
    final service = BiometricAuthService();
    expect(await service.authenticateWithBiometrics(), isTrue);
    expect(log.any((c) => c.method == 'authenticate'), isTrue);
  });

  test('fallback to pin when biometrics fail', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'authenticate') return false;
      if (call.method == 'isDeviceSupported') return true;
      return true;
    });

    await box.put('settings', const SecuritySettingsModel(
      biometricEnabled: true,
      encryptedPin: '1234',
      protectedModules: [],
    ));

    final service = BiometricAuthService();
    expect(await service.authenticateOrPin(''), isTrue);
  });
}
