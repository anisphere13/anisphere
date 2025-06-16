import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import '../../test_config.dart';
import 'package:anisphere/modules/noyau/models/payment_plan.dart';
import 'package:anisphere/modules/noyau/services/payment_service.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import 'package:anisphere/modules/noyau/services/stripe_checkout_service.dart';
import 'package:anisphere/modules/noyau/logic/ia_logger.dart';

class FakeStripeCheckoutService extends StripeCheckoutService {
  bool called = false;

  @override
  Future<void> openCheckout(PaymentPlan plan) async {
    called = true;
  }
}

class TestPaymentService extends PaymentService {
  final FakeStripeCheckoutService stripe;

  TestPaymentService(this.stripe) : super(stripeService: stripe);

  @override
  bool get isIapSupported => false;
}

void main() {
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    await LocalStorageService.init();
    await IALogger.clearLogs();
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('users');
    await Hive.deleteBoxFromDisk('animals');
    await Hive.deleteBoxFromDisk('settings');
    await tempDir.delete(recursive: true);
  });

  test('purchaseItem updates state and streams subscriptions', () async {
    final service = PaymentService();
    const plan = PaymentPlan(
      id: 'premium',
      name: 'Premium',
      price: 1.0,
      description: 'x',
    );

    final firstUpdate = service.subscriptionUpdates.first;
    await service.purchaseItem(plan);
    final subs = await firstUpdate;

    expect(service.state, PurchaseState.purchased);
    expect(subs, ['premium']);
    expect(await service.getActiveSubscriptions(), ['premium']);
    final logs = IALogger.getLogs();
    expect(logs.any((l) => l.contains('IAP_PURCHASED')), isTrue);
  });

  test('uses StripeCheckoutService when IAP unsupported', () async {
    final stripe = FakeStripeCheckoutService();
    final service = TestPaymentService(stripe);

    await service.purchaseItem(const PaymentPlan(
      id: 'test',
      name: 'Test',
      price: 0,
      description: 'd',
    ));

    expect(stripe.called, isTrue);
  });

  test('dispose closes stream controller', () async {
    final service = PaymentService();
    service.dispose();

    expect(
      () => service.purchaseItem(const PaymentPlan(
        id: 'p',
        name: 'n',
        price: 1,
        description: 'd',
      )),
      throwsA(isA<StateError>()),
    );
  });
}

