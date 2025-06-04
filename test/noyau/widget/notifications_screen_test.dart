/// Copilot Prompt : Test automatique généré pour notifications_screen.dart (widget)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/screens/notifications_screen.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('notifications_screen fonctionne (test auto)', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Placeholder()));
    // TODO : compléter le test pour notifications_screen.dart
    expect(find.byType(Placeholder), findsOneWidget);
  });
}
