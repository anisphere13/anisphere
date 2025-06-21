// Copilot Prompt : Test automatique généré pour more_menu.dart (widget)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/widgets/more_menu.dart';
import 'package:anisphere/l10n/app_localizations.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('shows menu items when tapped', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: const Locale('fr'),
        home: const Scaffold(body: MoreMenuButton()),
      ),
    );
    await tester.tap(find.byType(MoreMenuButton));
    await tester.pumpAndSettle();

    expect(find.text('Mon profil'), findsOneWidget);
    expect(find.text('Paramètres'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('À propos'), findsOneWidget);
  });
}
