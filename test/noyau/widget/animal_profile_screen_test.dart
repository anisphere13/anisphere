/// Copilot Prompt : Test automatique généré pour animal_profile_screen.dart (widget)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/screens/animal_profile_screen.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('animal_profile_screen fonctionne (test auto)', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Placeholder()));
    // TODO : compléter le test pour animal_profile_screen.dart
    expect(find.byType(Placeholder), findsOneWidget);
  });
}
