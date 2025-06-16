import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import '../../test_config.dart';
import 'package:anisphere/modules/noyau/models/payment_plan.dart';
import 'package:anisphere/modules/noyau/services/payment_service.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import 'package:anisphere/modules/noyau/logic/ia_logger.dart';

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

