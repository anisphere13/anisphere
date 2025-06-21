@Skip('Temporarily disabled')
library user_profile_model_test;
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/models/user_profile_model.dart';
void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('copyWith returns new instance with updated fields', () {
    final profile = UserProfileModel(
      id: 'u1',
      name: 'Test',
      email: 'e@test.com',
      phone: '123',
      profilePicture: '',
      profession: 'dev',
      ownedSpecies: const {},
      ownedAnimals: const [],
      preferences: const {},
      moduleRoles: const {},
      createdAt: DateTime(2024, 1, 1),
      updatedAt: DateTime(2024, 1, 2),
      activeModules: const [],
      role: 'user',
      iaPremium: false,
      birthDate: DateTime(2000, 1, 1),
      lastName: 'Doe',
      firstName: 'John',
      birthPlace: 'City',
      unit: 'Unit',
      company: 'Company',
      group: 'Group',
      nigend: '123',
      proValidated: true,
    );

    final copy = profile.copyWith(firstName: 'Jane', proValidated: false);

    expect(copy, isNot(same(profile)));
    expect(copy.firstName, 'Jane');
    expect(copy.proValidated, isFalse);
    expect(copy.lastName, profile.lastName);
    expect(copy.id, profile.id);
  });

  test('toJson/fromJson round trip', () {
    final profile = UserProfileModel(
      id: 'u1',
      name: 'Test',
      email: 'e@test.com',
      phone: '123',
      profilePicture: '',
      profession: 'dev',
      ownedSpecies: const {},
      ownedAnimals: const [],
      preferences: const {},
      moduleRoles: const {},
      createdAt: DateTime(2024, 1, 1),
      updatedAt: DateTime(2024, 1, 2),
      activeModules: const [],
      role: 'user',
      iaPremium: false,
      birthDate: DateTime(2000, 1, 1),
      lastName: 'Doe',
      firstName: 'John',
      birthPlace: 'City',
      unit: 'Unit',
      company: 'Company',
      group: 'Group',
      nigend: '123',
      proValidated: true,
    );

    final json = profile.toJson();
    final restored = UserProfileModel.fromJson(json);

    expect(restored.firstName, profile.firstName);
    expect(restored.lastName, profile.lastName);
    expect(restored.birthPlace, profile.birthPlace);
    expect(restored.nigend, profile.nigend);
    expect(restored.birthDate, profile.birthDate);
  });
}
