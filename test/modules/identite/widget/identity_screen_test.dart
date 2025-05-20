import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:anisphere/modules/identite/screens/identity_screen.dart';
import 'package:anisphere/modules/identite/services/identity_service.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';

import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

class MockBox extends Mock implements Box {}

void main() {
  testWidgets('IdentityScreen renders input fields', (WidgetTester tester) async {
    final service = IdentityService(localBox: MockBox());
    final animal = AnimalModel(id: 'test');

    await tester.pumpWidget(MaterialApp(
      home: IdentityScreen(animal: animal, service: service),
    ));

    await tester.pump(); // allow future to resolve

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Sauvegarder'), findsOneWidget);
  });
}
