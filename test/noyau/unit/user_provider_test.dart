import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import '../../test_config.dart';
import 'package:mockito/mockito.dart';

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

class MockAuthService extends Mock implements AuthService {}

class MockUserService extends Mock implements UserService {}

class FakeConnectivityPlatform extends ConnectivityPlatform {
  List<ConnectivityResult> results;
  FakeConnectivityPlatform(this.results);

  @override
  Future<List<ConnectivityResult>> checkConnectivity() async => results;

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      Stream.value(results);
}

void main() {
  late ConnectivityPlatform previous;

  setUpAll(() async {
    await initTestEnv();
  });

  setUp(() {
    previous = ConnectivityPlatform.instance;
  });

  tearDown(() {
    ConnectivityPlatform.instance = previous;
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

    ConnectivityPlatform.instance =
        FakeConnectivityPlatform([ConnectivityResult.wifi]);
    await provider.signOut();
    expect(service.initCalled, isTrue);
    expect(service.deleteCalled, isTrue);
    expect(provider.user, isNull);
  });

  test('signOut calls AuthService.signOut and removes user locally', () async {
    final mockAuth = MockAuthService();
    final mockService = MockUserService();

    when(mockService.init()).thenAnswer((_) async {});
    when(mockService.deleteUserLocally()).thenAnswer((_) async {});
    when(mockService.updateUser(any<UserModel>()))
        .thenAnswer((_) async => true);
    when(mockAuth.signOut()).thenAnswer((_) async {});

    final provider = UserProvider(mockService, mockAuth);
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
    ConnectivityPlatform.instance =
        FakeConnectivityPlatform([ConnectivityResult.wifi]);
    await provider.signOut();

    verify(mockService.init()).called(1);
    verify(mockService.deleteUserLocally()).called(1);
    verify(mockAuth.signOut()).called(1);
    expect(provider.user, isNull);
  });

  test('signOut does not call AuthService.signOut when offline', () async {
    final mockAuth = MockAuthService();
    final mockService = MockUserService();

    when(mockService.init()).thenAnswer((_) async {});
    when(mockService.deleteUserLocally()).thenAnswer((_) async {});
    when(mockService.updateUser(any<UserModel>()))
        .thenAnswer((_) async => true);
    when(mockAuth.signOut()).thenAnswer((_) async {});

    final provider = UserProvider(mockService, mockAuth);
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
    ConnectivityPlatform.instance =
        FakeConnectivityPlatform([ConnectivityResult.none]);
    await provider.signOut();

    verify(mockService.init()).called(1);
    verify(mockService.deleteUserLocally()).called(1);
    verifyNever(mockAuth.signOut());
    expect(provider.user, isNull);
  });
}
