import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'package:anisphere/modules/noyau/services/cgu_manager.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import 'package:anisphere/modules/noyau/screens/legal_screen.dart';
import 'package:anisphere/modules/noyau/services/navigation_service.dart';

import '../../test_config.dart';

class MockRemoteConfig extends Mock implements FirebaseRemoteConfig {}

void main() {
  late Directory tempDir;
  late MockRemoteConfig mockConfig;

  setUpAll(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    await LocalStorageService.init();
  });

  tearDownAll(() async {
    await Hive.deleteBoxFromDisk('users');
    await Hive.deleteBoxFromDisk('animals');
    await Hive.deleteBoxFromDisk('settings');
    await tempDir.delete(recursive: true);
  });

  setUp(() {
    mockConfig = MockRemoteConfig();
    when(mockConfig.setDefaults(any<Map<String, dynamic>>()))
        .thenAnswer((_) async {});
    when(mockConfig.fetchAndActivate()).thenAnswer((_) async => true);
    when(mockConfig.getString('cgu_version')).thenReturn('2');
    when(mockConfig.getString('privacy_version')).thenReturn('3');
  });

  test('acceptCurrent stores versions from Remote Config', () async {
    final manager = CguManager(remoteConfig: mockConfig);

    await manager.acceptCurrent();

    expect(LocalStorageService.get('accepted_cgu_version'), '2');
    expect(LocalStorageService.get('accepted_privacy_version'), '3');
  });

  testWidgets('ensureLatestAccepted navigates to LegalScreen when outdated',
      (tester) async {
    await LocalStorageService.set('accepted_cgu_version', '1');
    await LocalStorageService.set('accepted_privacy_version', '1');

    final manager = CguManager(remoteConfig: mockConfig);

    await tester.pumpWidget(MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      home: const SizedBox(),
    ));

    await manager.ensureLatestAccepted();
    await tester.pumpAndSettle();

    expect(find.byType(LegalScreen), findsOneWidget);
  });
}
