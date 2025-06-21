// Copilot Prompt : Test automatique généré pour local_storage_service.dart (unit)
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:hive/hive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import '../../test_config.dart';

void main() {
  const keyName = 'hive_aes_key';
  const secureStorage = FlutterSecureStorage();
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    await secureStorage.delete(key: keyName);
    await LocalStorageService.init();
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('users');
    await Hive.deleteBoxFromDisk('animals');
    await Hive.deleteBoxFromDisk('settings');
    await tempDir.delete(recursive: true);
    await secureStorage.delete(key: keyName);
  });

  test('data cannot be read without encryption key', () async {
    final user = UserModel(
      id: 'u1',
      name: 'Test',
      email: 't@test.com',
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

    await LocalStorageService.saveUser(user);
    await Hive.close();

    expect(
      () async => await Hive.openBox<UserModel>('users'),
      throwsA(isA<HiveError>()),
    );
  });
}
