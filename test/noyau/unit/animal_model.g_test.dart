// Copilot Prompt : Test automatique généré pour animal_model.g.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/models/animal_model.g.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('AnimalModelAdapter typeId is 1', () {
    expect(AnimalModelAdapter().typeId, 1);
  });
}
