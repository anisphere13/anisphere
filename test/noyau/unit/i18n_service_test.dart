// Copilot Prompt : Test automatique généré pour i18n_service.dart (unit)
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:anisphere/modules/noyau/i18n/i18n_service.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('setLocale stores the locale and getCurrentLocale retrieves it', () async {
    await LocalStorageService.init();
    await I18nService.setLocale(const Locale('fr'));
    final locale = I18nService.getCurrentLocale();
    expect(locale.languageCode, 'fr');
  });

  test('getCurrentLocale returns default when none saved', () async {
    final dir = await Directory.systemTemp.createTemp();
    Hive.init(dir.path);
    await LocalStorageService.init();

    // Ensure no locale is stored
    await LocalStorageService.remove('locale');

    final locale = I18nService.getCurrentLocale();
    expect(locale.languageCode, 'en');

    await Hive.deleteBoxFromDisk('users');
    await Hive.deleteBoxFromDisk('animals');
    await Hive.deleteBoxFromDisk('settings');
    await dir.delete(recursive: true);
  });
}
