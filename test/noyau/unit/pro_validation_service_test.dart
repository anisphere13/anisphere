import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/pro_validation_service.dart';
import 'package:anisphere/modules/noyau/models/user_profile_model.dart';
import 'package:anisphere/modules/noyau/services/firebase_service.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('validateProfessionalData returns false for empty fields', () async {
    final service = ProValidationService(testBox: await Hive.openBox<UserProfileModel>('profile'));
    final profile = UserProfileModel(
      id: '1',
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
    expect(service.validateProfessionalData(profile), isFalse);
    await Hive.deleteBoxFromDisk('profile');
  });

  test('pairValidate checks user existence', () async {
    final firestore = FakeFirebaseFirestore();
    await firestore.collection('users').doc('u1').set({'id': 'u1'});
    final service = ProValidationService(
      firebaseService: FirebaseService(firestore: firestore),
      testBox: await Hive.openBox<UserProfileModel>('profile2'),
    );
    final profile = UserProfileModel(
      id: '1',
      name: 'n',
      email: 'e',
      phone: '1',
      profilePicture: '',
      profession: 'p',
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
    expect(await service.pairValidate(profile, 'u1'), isTrue);
    expect(await service.pairValidate(profile, 'missing'), isFalse);
    await Hive.deleteBoxFromDisk('profile2');
  });
}
