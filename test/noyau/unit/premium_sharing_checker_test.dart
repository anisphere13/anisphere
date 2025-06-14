import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/services/premium_sharing_checker.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';

class FakeUserProvider extends UserProvider {
  FakeUserProvider(UserModel user) : super(null, null) {
    _user = user;
  }
}

void main() {
  test('canUseCloudSharing retourne true si iaPremium', () {
    final user = UserModel(
      id: '1',
      name: 'a',
      email: 'b',
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
      iaPremium: true,
    );
    final provider = FakeUserProvider(user);
    final checker = PremiumSharingChecker(userProvider: provider);
    expect(checker.canUseCloudSharing(), isTrue);
  });
}
