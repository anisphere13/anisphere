import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:anisphere/modules/noyau/i18n/language_selector_widget.dart';
import 'package:anisphere/modules/noyau/providers/i18n_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('shows and changes language', (tester) async {
    final provider = I18nProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: LanguageSelectorWidget()),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('English'), findsOneWidget);

    await tester.tap(find.byType(DropdownButton<Locale>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Français').last);
    await tester.pumpAndSettle();

    expect(provider.locale.languageCode, 'fr');
  });
}
