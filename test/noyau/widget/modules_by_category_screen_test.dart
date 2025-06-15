// Copilot Prompt : Test automatique généré pour modules_by_category_screen.dart (widget)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:anisphere/modules/noyau/screens/modules_by_category_screen.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('renders AppBar with category title', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ModulesByCategoryScreen(category: 'Général'),
    ));
    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Général'), findsOneWidget);
  });
}
