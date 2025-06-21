import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:provider/provider.dart';

import 'package:anisphere/modules/noyau/i18n/i18n_provider.dart';
import 'package:anisphere/modules/noyau/i18n/language_selector_widget.dart';
import 'package:anisphere/l10n/app_localizations.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('selecting a language updates provider', (tester) async {
    final provider = I18nProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider<I18nProvider>.value(
        value: provider,
        child: MaterialApp(
          locale: const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const Scaffold(body: LanguageSelectorWidget()),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(provider.locale, const Locale('en'));

    await tester.tap(find.byType(DropdownButton<Locale>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('French').last);
    await tester.pumpAndSettle();

    expect(provider.locale, const Locale('fr'));
  });
}
