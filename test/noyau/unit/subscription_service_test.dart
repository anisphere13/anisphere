import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import '../../test_config.dart';
import 'package:anisphere/modules/noyau/models/subscription_model.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    await LocalStorageService.init();
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('users');
    await Hive.deleteBoxFromDisk('animals');
    await Hive.deleteBoxFromDisk('subscriptions');
    await Hive.deleteBoxFromDisk('settings');
    await tempDir.delete(recursive: true);
  });

  test('save and retrieve subscription', () async {
    final now = DateTime.now();
    final sub = SubscriptionModel(
      id: 's1',
      userId: 'u1',
      type: 'premium',
      startDate: now,
      expiryDate: now.add(const Duration(days: 30)),
      status: SubscriptionStatus.active,
    );

    await LocalStorageService.saveSubscription(sub);
    final retrieved = LocalStorageService.getSubscription('s1');

    expect(retrieved, isNotNull);
    expect(retrieved!.type, 'premium');
  });
}
