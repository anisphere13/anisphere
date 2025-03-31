import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';

void main() {
  group('ANIMAL_MODEL - Test d’intégration', () {
    test('Création et lecture complète', () {
      final now = DateTime.now();

      final animal = AnimalModel(
        id: 'a1',
        name: 'Rex',
        species: 'chien',
        breed: 'labrador',
        imageUrl: 'https://image.com/rex.png',
        ownerId: 'u1',
        createdAt: now,
        updatedAt: now,
      );

      final map = animal.toJson();
      final retrieved = AnimalModel.fromJson(map);

      expect(retrieved.id, equals('a1'));
      expect(retrieved.name, equals('Rex'));
      expect(retrieved.species, equals('chien'));
      expect(retrieved.breed, equals('labrador'));
      expect(retrieved.ownerId, equals('u1'));
      expect(retrieved.imageUrl, equals('https://image.com/rex.png'));
    });

    test('Copie avec modification', () {
      final base = AnimalModel(
        id: 'a1',
        name: 'Rex',
        species: 'chien',
        breed: 'labrador',
        imageUrl: '',
        ownerId: 'u1',
        createdAt: DateTime(2022),
        updatedAt: DateTime(2022),
      );

      final updated = base.copyWith(name: 'Max');

      expect(updated.id, equals('a1'));
      expect(updated.name, equals('Max'));
      expect(updated.species, equals('chien'));
    });
  });
}
