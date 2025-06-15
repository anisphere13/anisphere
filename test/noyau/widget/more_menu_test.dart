// Copilot Prompt : Test automatique généré pour more_menu.dart (widget)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/widgets/more_menu.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('shows menu items when tapped', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: MoreMenuButton())));
    await tester.tap(find.byType(MoreMenuButton));
    await tester.pumpAndSettle();

    expect(find.text('Mon profil'), findsOneWidget);
    expect(find.text('Paramètres'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('À propos'), findsOneWidget);
  });
}
