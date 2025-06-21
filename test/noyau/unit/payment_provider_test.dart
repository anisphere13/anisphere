// Copilot Prompt : Test automatique généré pour payment_provider.dart (unit)
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/providers/payment_provider.dart';
import 'package:anisphere/modules/noyau/services/payment_service.dart';

class FakePaymentService extends PaymentService {
  final StreamController<List<String>> controller =
      StreamController<List<String>>.broadcast();
  List<String> current = [];

  @override
  Stream<List<String>> get subscriptionUpdates => controller.stream;

  @override
  Future<List<String>> getActiveSubscriptions() async => current;

  void emit(List<String> subs) {
    current = subs;
    controller.add(subs);
  }

  @override
  void dispose() {
    controller.close();
  }
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('isPremium reflects subscription updates', () async {
    final service = FakePaymentService();
    final provider = PaymentProvider(service: service);
    await provider.init();

    expect(provider.isPremium, isFalse);

    final first = provider.subscriptions.first;
    service.emit(['premium']);
    final subs = await first;

    expect(provider.isPremium, isTrue);
    expect(subs, ['premium']);

    provider.dispose();
  });
}
