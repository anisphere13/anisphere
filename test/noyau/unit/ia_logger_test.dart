// Copilot Prompt : Test automatique généré pour ia_logger.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/logic/ia_logger.dart';
import 'package:anisphere/modules/noyau/logic/ia_channel.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('getLogs returns empty list by default', () {
    final logs = IALogger.getLogs();
    expect(logs, isEmpty);
  });
}
