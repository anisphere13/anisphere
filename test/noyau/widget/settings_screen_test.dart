// Copilot Prompt : Test automatique généré pour settings_screen.dart (widget)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:anisphere/modules/noyau/screens/settings_screen.dart';
import 'package:anisphere/modules/noyau/screens/iap_screen.dart';
import 'package:anisphere/modules/noyau/providers/payment_provider.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('premium tile navigates to IAPScreen', (tester) async {
    final provider = PaymentProvider();
    await provider.init();
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Passer Premium'), findsOneWidget);
    await tester.tap(find.text('Passer Premium'));
    await tester.pumpAndSettle();

    expect(find.byType(IAPScreen), findsOneWidget);

    provider.dispose();
  });
}
