// Copilot Prompt : Test automatique généré pour animals_screen.dart (widget)
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/noyau/screens/animals_screen.dart';
import '../../test_config.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(AnimalModelAdapter());
    await Hive.openBox<AnimalModel>('animal_data');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('animal_data');
    await tempDir.delete(recursive: true);
  });

  testWidgets('renders without AppBar', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AnimalsScreen()));
    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsNothing);
    expect(find.text('Aucun animal enregistré'), findsOneWidget);
  });
}
