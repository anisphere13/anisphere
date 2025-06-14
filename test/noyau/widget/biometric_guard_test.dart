import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/widgets/biometric_guard.dart';
import 'package:anisphere/modules/noyau/models/security_settings_model.dart';
import '../../test_config.dart';

void main() {
  const channel = MethodChannel('plugins.flutter.io/local_auth');
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive
      ..init(tempDir.path)
      ..registerAdapter(SecuritySettingsModelAdapter());
    await Hive.openBox<SecuritySettingsModel>('securitySettings')
        .put('settings', const SecuritySettingsModel(biometricEnabled: true, encryptedPin: '1234', protectedModules: []));
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
      if (call.method == 'authenticate') return true;
      return true;
    });
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('securitySettings');
    await tempDir.delete(recursive: true);
  });

  testWidgets('child visible on successful auth', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: BiometricGuard(child: Text('Secret')),
    ));
    await tester.pumpAndSettle();
    expect(find.text('Secret'), findsOneWidget);
  });

  testWidgets('shows access denied on failure', (tester) async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'authenticate') return false;
      return true;
    });
    await tester.pumpWidget(const MaterialApp(
      home: BiometricGuard(child: Text('Secret')),
    ));
    await tester.pumpAndSettle();
    expect(find.text('Accès refusé'), findsOneWidget);
  });
}
