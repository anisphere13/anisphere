import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:anisphere/modules/noyau/screens/modules_by_category_screen.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('shows modules with AppBar title', (tester) async {
    final modules = [
      {'name': 'Test Module', 'description': 'demo'},
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: ModulesByCategoryScreen(category: 'Demo', modules: modules),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Demo'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Test Module'), findsOneWidget);
  });
}
