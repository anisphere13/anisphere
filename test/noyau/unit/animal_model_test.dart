import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';

void main() {
  group('ANIMAL_MODEL - Test unitaire', () {
    test('Création d\'un animal valide', () {
      final animal = AnimalModel(
        id: '123',
        nom: 'Rex',
        espece: 'chien',
        dateNaissance: DateTime(2020, 1, 1),
        poids: 30.5,
      );

      expect(animal.nom, 'Rex');
      expect(animal.espece, 'chien');
      expect(animal.poids, greaterThan(0));
    });

    test('Conversion toMap et fromMap', () {
      final animal = AnimalModel(
        id: '123',
        nom: 'Milo',
        espece: 'chat',
        dateNaissance: DateTime(2021, 5, 10),
        poids: 4.2,
      );

      final map = animal.toMap();
      final fromMap = AnimalModel.fromMap(map);

      expect(fromMap.id, animal.id);
      expect(fromMap.nom, animal.nom);
      expect(fromMap.espece, animal.espece);
    });
  });
}
