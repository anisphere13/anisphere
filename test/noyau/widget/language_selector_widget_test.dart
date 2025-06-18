import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:anisphere/modules/noyau/i18n/i18n_provider.dart';
import '../../test_config.dart';

class _LanguageSelectorWidget extends StatelessWidget {
  const _LanguageSelectorWidget();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<I18nProvider>();
    return DropdownButton<Locale>(
      key: const Key('languageSelector'),
      value: provider.locale,
      onChanged: (locale) {
        if (locale != null) {
          context.read<I18nProvider>().setLocale(locale);
        }
      },
      items: const [
        DropdownMenuItem(value: Locale('en'), child: Text('English')),
        DropdownMenuItem(value: Locale('fr'), child: Text('Français')),
      ],
    );
  }
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('selecting a language updates provider', (tester) async {
    final provider = I18nProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider<I18nProvider>.value(
        value: provider,
        child: const MaterialApp(
          home: Scaffold(body: _LanguageSelectorWidget()),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(provider.locale, const Locale('en'));

    await tester.tap(find.byKey(const Key('languageSelector')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Français').last);
    await tester.pumpAndSettle();

    expect(provider.locale, const Locale('fr'));
  });
}
