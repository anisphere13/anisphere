// Copilot Prompt : Test automatique généré pour i18n_service.dart (unit)
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:anisphere/modules/noyau/services/i18n_service.dart'
    as hive_service;
import 'package:anisphere/modules/noyau/i18n/i18n_service.dart'
    as i18n_service;
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('saveLocale stores the locale and loadLocale retrieves it', () async {
    final dir = await Directory.systemTemp.createTemp();
    Hive.init(dir.path);
    final box = await Hive.openBox('settings');
    final service = hive_service.I18nService(testBox: box);

    await service.saveLocale('fr');
    expect(box.get('locale'), 'fr');
    expect(service.loadLocale(), 'fr');

    await box.deleteFromDisk();
    await dir.delete(recursive: true);
  });

  test('getCurrentLocale returns default when none saved', () async {
    final dir = await Directory.systemTemp.createTemp();
    Hive.init(dir.path);
    await LocalStorageService.init();

    // Ensure no locale is stored
    await LocalStorageService.remove('locale');

    final locale = i18n_service.I18nService.getCurrentLocale();
    expect(locale.languageCode, 'en');

    await Hive.deleteBoxFromDisk('users');
    await Hive.deleteBoxFromDisk('animals');
    await Hive.deleteBoxFromDisk('settings');
    await dir.delete(recursive: true);
  });
}
