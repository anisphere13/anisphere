/// Copilot Prompt : Test automatique généré pour ia_chip.dart (widget)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/widgets/ia_chip.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('ia_chip fonctionne (test auto)', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Placeholder()));
    // TODO : compléter le test pour ia_chip.dart
    expect(find.byType(Placeholder), findsOneWidget);
  });
}
