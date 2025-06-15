// Copilot Prompt : Test automatique généré pour modules_screen.dart (widget)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:anisphere/modules/noyau/screens/modules_screen.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('renders modules grouped by category', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ModulesScreen()));
    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsNothing);
    expect(find.text('Santé'), findsOneWidget);
    expect(find.text('Bien-être'), findsOneWidget);
  });
}
