import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';

void main() {
  group('ANIMAL_MODEL - Test unitaire', () {
    test('Création d\'un animal valide', () {
      final animal = AnimalModel(
        id: '123',
        name: 'Rex',
        species: 'chien',
        breed: 'labrador',
        imageUrl: 'http://exemple.com/image.jpg',
        ownerId: 'u1',
        createdAt: DateTime(2020, 1, 1),
        updatedAt: DateTime(2020, 1, 1),
      );

      expect(animal.name, 'Rex');
      expect(animal.species, 'chien');
      expect(animal.breed, 'labrador');
      expect(animal.imageUrl, contains('http'));
      expect(animal.ownerId, isNotEmpty);
    });

    test('Conversion toJson et fromJson', () {
      final animal = AnimalModel(
        id: '456',
        name: 'Milo',
        species: 'chat',
        breed: 'persan',
        imageUrl: 'http://exemple.com/image2.jpg',
        ownerId: 'u2',
        createdAt: DateTime(2021, 5, 10),
        updatedAt: DateTime(2021, 5, 12),
      );

      final map = animal.toJson();
      final fromMap = AnimalModel.fromJson(map);

      expect(fromMap.id, animal.id);
      expect(fromMap.name, animal.name);
      expect(fromMap.species, animal.species);
      expect(fromMap.breed, animal.breed);
    });
  });
}
