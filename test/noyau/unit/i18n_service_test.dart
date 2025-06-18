// Copilot Prompt : Test automatique généré pour i18n_service.dart (unit)
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:anisphere/modules/noyau/services/i18n_service.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('saveLocale stores the locale and loadLocale retrieves it', () async {
    final dir = await Directory.systemTemp.createTemp();
    Hive.init(dir.path);
    final box = await Hive.openBox('settings');
    final service = I18nService(testBox: box);

    await service.saveLocale('fr');
    expect(box.get('locale'), 'fr');
    expect(service.loadLocale(), 'fr');

    await box.deleteFromDisk();
    await dir.delete(recursive: true);
  });
}
