// Copilot Prompt : Test automatique généré pour iap_screen.dart (widget)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:anisphere/modules/noyau/screens/iap_screen.dart';
import 'package:anisphere/modules/noyau/providers/payment_provider.dart';
import 'package:anisphere/modules/noyau/services/payment_service.dart';
import 'package:anisphere/modules/noyau/models/payment_plan.dart';

import '../../test_config.dart';

class _TestPaymentService extends PaymentService {
  bool called = false;

  @override
  Future<void> purchaseItem(PaymentPlan plan, {String? receipt}) async {
    called = true;
  }
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('renders plans list', (tester) async {
    final provider = PaymentProvider();
    await provider.init();
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => provider,
        child: const MaterialApp(home: IapScreen()),
      ),
    );
    await tester.pump();

    expect(find.text('Premium Individuel'), findsOneWidget);
    expect(find.text('Pro / Éducateur'), findsOneWidget);

    provider.dispose();
  });

  testWidgets('purchase button calls service', (tester) async {
    final service = _TestPaymentService();
    final provider = PaymentProvider(service: service);
    await provider.init();
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => provider,
        child: const MaterialApp(home: IapScreen()),
      ),
    );
    await tester.pump();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Choisir').first);
    await tester.pump();

    expect(service.called, isTrue);

    provider.dispose();
  });
}
