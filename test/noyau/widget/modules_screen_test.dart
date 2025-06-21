import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:anisphere/modules/noyau/screens/modules_screen.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/modules/identite/screens/identity_screen.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import '../../test_config.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(IdentityModelAdapter());
    await LocalStorageService.init();
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('users');
    await Hive.deleteBoxFromDisk('animals');
    await Hive.deleteBoxFromDisk('settings');
    if (Hive.isBoxOpen('identityBox')) {
      await Hive.deleteBoxFromDisk('identityBox');
    }
    await tempDir.delete(recursive: true);
  });

  testWidgets('shows categories with horizontal module lists', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ModulesScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Bien-être'), findsOneWidget);
    expect(find.text('Apprentissage'), findsOneWidget);

    final listViews = tester.widgetList<ListView>(find.byType(ListView));
    expect(listViews.any((lv) => lv.scrollDirection == Axis.horizontal), isTrue);
  });

  testWidgets('loads when identityBox not opened', (tester) async {
    expect(Hive.isBoxOpen('identityBox'), isFalse);
    await tester.pumpWidget(const MaterialApp(home: ModulesScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Bien-être'), findsOneWidget);
  });

  testWidgets('opens IdentityScreen when identite module tapped', (tester) async {
    await ModulesService.activate('identite');
    await tester.pumpWidget(
      const MaterialApp(
        home: ModulesScreen(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Identité animale'), findsOneWidget);
    expect(find.text('Gratuit'), findsOneWidget);

    await tester.tap(find.text('Identité animale'));
    await tester.pumpAndSettle();

    expect(find.byType(IdentityScreen), findsOneWidget);
  });
}
