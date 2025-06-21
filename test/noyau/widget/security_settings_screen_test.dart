import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/screens/security_settings_screen.dart';
import 'package:anisphere/modules/noyau/models/security_settings_model.dart';
import '../../test_config.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive
      ..init(tempDir.path)
      ..registerAdapter(SecuritySettingsModelAdapter());
    await Hive.openBox<SecuritySettingsModel>('securitySettings');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('securitySettings');
    await tempDir.delete(recursive: true);
  });

  testWidgets('screen shows biometric switch', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SecuritySettingsScreen()));
    expect(find.byType(SwitchListTile), findsOneWidget);
  });
}
