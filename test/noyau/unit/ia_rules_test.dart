// Copilot Prompt : Test automatique généré pour ia_rules.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/logic/ia_rules.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('isAnimalInactive detects outdated update date', () {
    final animal = AnimalModel(
      id: 'a1',
      name: 'Test',
      species: 'dog',
      breed: '',
      imageUrl: '',
      ownerId: 'u1',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now().subtract(const Duration(days: 20)),
    );
    expect(IARules.isAnimalInactive(animal, threshold: const Duration(days: 7)),
        isTrue);
  });
}
