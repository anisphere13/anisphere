// Copilot Prompt : Test automatique généré pour ia_channel.dart (unit)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/logic/ia_channel.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('IAChannel extension returns expected name', () {
    expect(IAChannel.system.name, 'SYSTEM');
    expect(IAChannel.notification.name, 'NOTIFICATION');
  });
}
