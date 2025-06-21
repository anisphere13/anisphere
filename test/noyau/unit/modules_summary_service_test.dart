import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:anisphere/modules/noyau/services/modules_summary_service.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
import 'package:anisphere/modules/noyau/logic/ia_context.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';

import '../../test_config.dart';

class FakeAnimalService extends AnimalService {
  FakeAnimalService() : super(skipHiveInit: true);

  @override
  Future<List<AnimalModel>> getAllAnimals() async {
    return [
      AnimalModel(
        id: 'a1',
        name: 'Rex',
        species: 'chien',
        breed: 'berger',
        imageUrl: '',
        ownerId: 'u1',
        createdAt: DateTime(2023, 1, 1),
        updatedAt: DateTime(2023, 1, 1),
      )
    ];
  }
}

void main() {
  late Directory tempDir;

  setUpAll(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    await LocalStorageService.init();
    await LocalStorageService.set('module_status_sante', 'actif');
    await LocalStorageService.set('module_status_education', 'actif');
    await LocalStorageService.set('module_status_dressage', 'actif');
  });

  tearDownAll(() async {
    await Hive.deleteBoxFromDisk('users');
    await Hive.deleteBoxFromDisk('animals');
    await Hive.deleteBoxFromDisk('settings');
    await tempDir.delete(recursive: true);
  });

  test('generateSummaries returns summaries for active modules', () async {
    final service = ModulesSummaryService(
      animalService: FakeAnimalService(),
      context: IAContext.empty(),
    );

    final summaries = await service.generateSummaries();

    expect(summaries.length, 3);
    expect(summaries.map((s) => s.moduleName), containsAll(['Santé', 'Éducation', 'Dressage']));
  });
}
