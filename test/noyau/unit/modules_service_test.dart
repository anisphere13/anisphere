import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import '../../test_config.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';

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

  test('allModules contains Santé', () {
    expect(ModulesService.allModules, contains('Santé'));
  });

  test('activate and getStatus', () async {
    await ModulesService.activate('Santé');
    expect(ModulesService.getStatus('Santé'), 'actif');
  });

  test('markPremium updates status', () async {
    await ModulesService.markPremium('Éducation');
    expect(ModulesService.getStatus('Éducation'), 'premium');
  });

  test('resetAllStatuses resets to disponible', () async {
    await ModulesService.activate('Dressage');
    await ModulesService.resetAllStatuses();
    expect(ModulesService.getStatus('Dressage'), 'disponible');
  });

  test('getAllModulesStatus returns all modules', () async {
    final statuses = await ModulesService.getAllModulesStatus();
    expect(statuses.length, ModulesService.allModules.length);
  });

  test('getAllStatuses and setActive', () async {
    final service = ModulesService();
    await service.setActive('Santé');
    final statuses = await service.getAllStatuses();
    expect(statuses['Santé'], 'actif');
  });
}
