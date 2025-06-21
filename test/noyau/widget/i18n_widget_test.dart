import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:anisphere/l10n/app_localizations.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('renders translated title', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Builder(
          builder: (context) => Text(
            AppLocalizations.of(context)!.home_title,
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final context = tester.element(find.byType(Text));
    final expected = AppLocalizations.of(context)!.home_title;
    expect(find.text(expected), findsOneWidget);
  });
}
