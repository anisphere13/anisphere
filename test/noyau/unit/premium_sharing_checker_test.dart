import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:anisphere/modules/noyau/services/premium_sharing_checker.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';

class FakeUserProvider extends UserProvider {
  UserModel? _testUser;

  FakeUserProvider(UserModel user)
      : _testUser = user,
        super(UserService(skipHiveInit: true), AuthService());

  set testUser(UserModel user) => _testUser = user;

  @override
  UserModel? get user => _testUser;
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
