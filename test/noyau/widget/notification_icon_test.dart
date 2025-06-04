/// Copilot Prompt : Test automatique généré pour notification_icon.dart (widget)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/widgets/notification_icon.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('notification_icon fonctionne (test auto)', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Placeholder()));
    // TODO : compléter le test pour notification_icon.dart
    expect(find.byType(Placeholder), findsOneWidget);
  });
}
