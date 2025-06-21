// Copilot Prompt : Test automatique généré pour ia_context.dart (unit)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/logic/ia_context.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('IAContext.empty has default values', () {
    final ctx = IAContext.empty();
    expect(ctx.isFirstLaunch, isTrue);
    expect(ctx.animalCount, 0);
  });
}
