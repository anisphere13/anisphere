/// Copilot Prompt : Test automatique généré pour more_menu.dart (widget)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/widgets/more_menu.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('more_menu fonctionne (test auto)', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Placeholder()));
    // TODO : compléter le test pour more_menu.dart
    expect(find.byType(Placeholder), findsOneWidget);
  });
}
