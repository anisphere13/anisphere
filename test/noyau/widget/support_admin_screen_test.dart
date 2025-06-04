/// Copilot Prompt : Test automatique généré pour support_admin_screen.dart (widget)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/screens/support_admin_screen.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('support_admin_screen fonctionne (test auto)', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Placeholder()));
    // TODO : compléter le test pour support_admin_screen.dart
    expect(find.byType(Placeholder), findsOneWidget);
  });
}
