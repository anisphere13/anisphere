// Copilot Prompt : Test automatique généré pour backup_service.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/backup_service.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import '../../helpers/test_fakes.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('performBackup returns false without user', () async {
    final dir = await Directory.systemTemp.createTemp();
    Hive.init(dir.path);
    Hive.registerAdapter(AnimalModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
    final animalBox = await Hive.openBox<AnimalModel>('animals');
    final animalService =
        AnimalService(testBox: animalBox, skipHiveInit: true);
    final userService = UserService(
      firestore: FakeFirebaseFirestore(),
      skipHiveInit: true,
      testBox: await Hive.openBox<UserModel>('users'),
    );

    final backup = BackupService(
      userService: userService,
      animalService: animalService,
      firebaseService: FakeFirebaseService(FakeFirebaseFirestore()),
    );

    final result = await backup.performBackup();
    expect(result, isFalse);

    await animalBox.deleteFromDisk();
    await Hive.box<UserModel>('users').deleteFromDisk();
    await dir.delete(recursive: true);
  });
}
