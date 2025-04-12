import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';

import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
// TODO: vérifier que le mock existe et est bien généré

void main() {
  late MockBox<AnimalModel> mockBox;
  late AnimalService animalService;

  setUp(() {
    mockBox = MockBox<AnimalModel>();
    when(mockBox.isOpen).thenReturn(true);
    animalService = AnimalService(testBox: mockBox, skipHiveInit: true);
    return null;
});

  test('updateLocalAnimal() sauvegarde l’animal dans Hive', () async {
    final animal = AnimalModel(
      id: 'a1',
      name: 'Rex',
      species: 'chien',
      breed: 'berger',
      imageUrl: '',
      ownerId: 'u1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    when(mockBox.put(animal.id, animal)).thenAnswer((_) async {});
    await animalService.updateLocalAnimal(animal);
    verify(mockBox.put(animal.id, animal)).called(1);
  });
}
