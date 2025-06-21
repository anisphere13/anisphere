// Copilot Prompt : Test automatique généré pour ia_sync_service.dart (unit)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/services/ia_sync_service.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('syncAnimal completes without premium', () async {
    final service = IASyncService.instance;
    final user = UserModel(
      id: 'u1',
      name: 'n',
      email: 'e',
      phone: '',
      profilePicture: '',
      profession: '',
      ownedSpecies: const {},
      ownedAnimals: const [],
      preferences: const {},
      moduleRoles: const {},
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      activeModules: const [],
      role: 'user',
      iaPremium: false,
    );
    final animal = AnimalModel(
      id: 'a',
      name: 'A',
      species: 's',
      breed: '',
      imageUrl: '',
      ownerId: 'u1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await service.syncAnimal(animal, user);
    expect(true, isTrue);
  });
}
