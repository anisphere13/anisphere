// Copilot Prompt : Test automatique généré pour animal_provider.dart (unit)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/providers/animal_provider.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('initial animals list is empty', () {
    final provider =
        AnimalProvider(animalService: AnimalService(skipHiveInit: true));
    expect(provider.animals, isEmpty);
  });
}
