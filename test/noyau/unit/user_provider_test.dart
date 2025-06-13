import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import '../../test_config.dart';

class FakeUserService extends UserService {
  bool initCalled = false;
  bool deleteCalled = false;
  UserModel? updatedUser;

  FakeUserService() : super(skipHiveInit: true);

  @override
  Future<void> init() async {
    initCalled = true;
  }

  @override
  Future<bool> updateUser(UserModel user) async {
    updatedUser = user;
    return true;
  }

  @override
  Future<void> deleteUserLocally() async {
    deleteCalled = true;
  }
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('signOut clears user and deletes local data', () async {
    final service = FakeUserService();
    final provider = UserProvider(service, AuthService(userService: service));

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

    await provider.updateUser(user);
    expect(provider.user, isNotNull);

    await provider.signOut();
    expect(service.initCalled, isTrue);
    expect(service.deleteCalled, isTrue);
    expect(provider.user, isNull);
  });
}
