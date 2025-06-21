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

  test('allModules contains sante', () {
    expect(ModulesService.allModules, contains('sante'));
  });

  test('activate and getStatus', () async {
    await ModulesService.activate('sante');
    expect(ModulesService.getStatus('sante'), 'actif');
  });

  test('isActive returns true when module is actif', () async {
    await ModulesService.activate('education');
    expect(ModulesService.isActive('education'), isTrue);
  });

  test('markPremium updates status', () async {
    await ModulesService.markPremium('education');
    expect(ModulesService.getStatus('education'), 'premium');
  });

  test('resetAllStatuses resets to disponible', () async {
    await ModulesService.activate('dressage');
    await ModulesService.resetAllStatuses();
    expect(ModulesService.getStatus('dressage'), 'disponible');
  });

  test('getAllModulesStatus returns all modules', () async {
    final statuses = await ModulesService.getAllModulesStatus();
    expect(statuses.length, ModulesService.allModules.length);
  });

  test('getAllStatuses and setActive', () async {
    final service = ModulesService();
    await service.setActive('sante');
    final statuses = await service.getAllStatuses();
    expect(statuses['sante'], 'actif');
  });
}
