// Copilot Prompt : Test automatique généré pour ia_logger.dart (unit)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'dart:io';

import '../../test_config.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/logic/ia_logger.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import 'package:anisphere/modules/noyau/services/payment_service.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    await LocalStorageService.init();
  });

  tearDownAll(() async {
    await Hive.deleteBoxFromDisk('users');
    await Hive.deleteBoxFromDisk('animals');
    await Hive.deleteBoxFromDisk('settings');
    await tempDir.delete(recursive: true);
  });
  test('getLogs returns empty list by default', () {
    final logs = IALogger.getLogs();
    expect(logs, isEmpty);
  });

  test('PaymentService triggers IAP logs', () async {
    final service = PaymentService();
    await service.updateState(PurchaseState.purchased);
    await service.updateState(PurchaseState.expired);
    await service.updateState(PurchaseState.cancelled);

    final logs = IALogger.getLogs();
    expect(logs.any((l) => l.contains('IAP_PURCHASED')), isTrue);
    expect(logs.any((l) => l.contains('IAP_EXPIRED')), isTrue);
    expect(logs.any((l) => l.contains('IAP_CANCELLED')), isTrue);
  });
}
