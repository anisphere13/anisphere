// Copilot Prompt : Test automatique généré pour ia_flag.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/logic/ia_flag.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('reset restores default values', () {
    IAFlag.enableSync = false;
    IAFlag.offlineOnly = true;

    IAFlag.reset();

    expect(IAFlag.enableSync, isTrue);
    expect(IAFlag.offlineOnly, isFalse);
  });
}
