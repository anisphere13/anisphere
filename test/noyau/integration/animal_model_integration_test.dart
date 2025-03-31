import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:anisphere/modules/noyau/models/animal_model.dart';

void main() {
  group('ANIMAL_MODEL - Test d’intégration Hive', () {
    late Box box;

    setUpAll(() async {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      Hive.registerAdapter(AnimalModelAdapter());

      box = await Hive.openBox('test_animals');
    });

    tearDownAll(() async {
      await box.clear();
      await box.close();
    });

    test('Sauvegarde et récupération d’un animal', () async {
      final animal = AnimalModel(
        id: '001',
        nom: 'Rex',
        espece: 'chien',
        dateNaissance: DateTime(2020, 1, 1),
        poids: 25.0,
      );

      await box.put(animal.id, animal);
      final retrieved = box.get(animal.id) as AnimalModel;

      expect(retrieved.nom, equals('Rex'));
      expect(retrieved.espece, equals('chien'));
      expect(retrieved.poids, greaterThan(0));
    });
  });
}
