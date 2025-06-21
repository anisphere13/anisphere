// Copilot Prompt : Test automatique généré pour animal_service.dart (unit)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('updateLocalAnimal stores and retrieves animal', () async {
    final dir = await Directory.systemTemp.createTemp();
    Hive.init(dir.path);
    Hive.registerAdapter(AnimalModelAdapter());
    final box = await Hive.openBox<AnimalModel>('test_animals');

    final service =
        AnimalService(testBox: box, skipHiveInit: true);
    final animal = AnimalModel(
      id: 'a1',
      name: 'Rex',
      species: 'dog',
      breed: 'labrador',
      imageUrl: '',
      ownerId: 'u1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await service.updateLocalAnimal(animal);
    final fetched = service.getAnimal('a1');

    expect(fetched?.name, 'Rex');

    await box.deleteFromDisk();
    await dir.delete(recursive: true);
  });
}
