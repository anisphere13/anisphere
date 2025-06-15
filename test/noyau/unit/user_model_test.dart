// Copilot Prompt : Test automatique généré pour user_model.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('toJson/fromJson round trip', () {
    final user = UserModel(
      id: 'u1',
      name: 'name',
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
    final json = user.toJson();
    final copy = UserModel.fromJson(json);
    expect(copy.id, 'u1');
    expect(copy.email, 'e');
  });
}
