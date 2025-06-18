// Copilot Prompt : Test widget utilisant AppLocalizations fictif
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:anisphere/modules/noyau/i18n/i18n_service.dart';

import '../../test_config.dart';

class TestLocalizations {
  final Locale locale;
  TestLocalizations(this.locale);

  static const LocalizationsDelegate<TestLocalizations> delegate = _TestDelegate();
  static const supportedLocales = [Locale('en'), Locale('fr')];

  static Future<TestLocalizations> load(Locale locale) async => TestLocalizations(locale);

  static TestLocalizations of(BuildContext context) {
    return Localizations.of<TestLocalizations>(context, TestLocalizations)!;
  }

  String get hello => locale.languageCode == 'fr' ? 'Bonjour' : 'Hello';
}

class _TestDelegate extends LocalizationsDelegate<TestLocalizations> {
  const _TestDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<TestLocalizations> load(Locale locale) => TestLocalizations.load(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<TestLocalizations> old) => false;
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('renders translated hello', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        supportedLocales: TestLocalizations.supportedLocales,
        localizationsDelegates: const [TestLocalizations.delegate],
        home: Builder(
          builder: (context) => Text(TestLocalizations.of(context).hello, textDirection: TextDirection.ltr),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Bonjour'), findsOneWidget);
  });
}
