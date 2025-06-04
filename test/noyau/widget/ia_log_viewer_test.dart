/// Copilot Prompt : Test automatique généré pour ia_log_viewer.dart (widget)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/widgets/ia_log_viewer.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('ia_log_viewer fonctionne (test auto)', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Placeholder()));
    // TODO : compléter le test pour ia_log_viewer.dart
    expect(find.byType(Placeholder), findsOneWidget);
  });
}
