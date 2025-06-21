// Copilot Prompt : Test automatique généré pour ia_rule_engine.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/logic/ia_rule_engine.dart';
import 'package:anisphere/modules/noyau/logic/ia_context.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('evaluate suggests adding animal when none present', () {
    final ctx = IAContext.empty();
    final actions = IARuleEngine.evaluate(ctx);
    expect(actions, contains('suggest_add_animal'));
  });
}
