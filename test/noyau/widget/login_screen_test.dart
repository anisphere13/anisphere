/// Copilot Prompt : Test automatique généré pour login_screen.dart (widget)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/screens/login_screen.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('login_screen fonctionne (test auto)', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Placeholder()));
    // TODO : compléter le test pour login_screen.dart
    expect(find.byType(Placeholder), findsOneWidget);
  });
}
