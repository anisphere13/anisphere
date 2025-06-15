// Copilot Prompt : Test automatique généré pour ia_config.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/logic/ia_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('maxLocalLogs greater than logsTrimTarget', () {
    expect(IAConfig.maxLocalLogs, greaterThan(IAConfig.logsTrimTarget));
  });
}
