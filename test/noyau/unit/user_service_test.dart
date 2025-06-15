// Copilot Prompt : Test automatique généré pour user_service.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('getUserFromHive retrieves stored user', () async {
    final dir = await Directory.systemTemp.createTemp();
    Hive.init(dir.path);
    Hive.registerAdapter(UserModelAdapter());
    final box = await Hive.openBox<UserModel>('users');
    final service = UserService(testBox: box, firestore: FakeFirebaseFirestore(), skipHiveInit: true);
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
    await service.saveUserLocally(user);
    final fetched = service.getUserFromHive();
    expect(fetched?.id, 'u1');
    await box.deleteFromDisk();
    await dir.delete(recursive: true);
  });
}
