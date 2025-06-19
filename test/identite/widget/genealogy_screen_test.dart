import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/l10n/app_localizations.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/screens/genealogy_screen.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('GenealogyScreen shows title', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: const Locale('fr'),
      home: const GenealogyScreen(),
    ));
    await tester.pump();
    expect(find.text('Généalogie'), findsOneWidget);
    expect(find.text('Écran de généalogie'), findsOneWidget);
  });
}
