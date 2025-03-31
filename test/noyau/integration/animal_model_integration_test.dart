import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';

void main() {
  group('ANIMAL_MODEL - Test d’intégration', () {
    test('Création et vérification d\'un animal', () {
      final animal = AnimalModel(
        id: '123',
        name: 'Rex',
        species: 'chien',
        breed: 'Berger',
        imageUrl: 'url',
        ownerId: 'owner123',
        createdAt: DateTime(2020, 1, 1),
        updatedAt: DateTime(2020, 1, 1),
      );

      final map = animal.toJson();
      final retrieved = AnimalModel.fromJson(map);

      expect(retrieved.name, equals('Rex'));
      expect(retrieved.species, equals('chien'));
      expect(retrieved.breed, equals('Berger'));
    });
  });
}
