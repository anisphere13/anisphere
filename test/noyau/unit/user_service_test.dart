// 📁 test/noyau/unit/user_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:hive/hive.dart';

import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';

import 'user_service_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late MockBox<UserModel> mockBox;
  late UserService userService;

  final testUser = UserModel(
    id: 'u1',
    name: 'Alice',
    email: 'alice@mail.com',
    phone: '0000000000',
    profilePicture: '',
    profession: 'éducateur',
    ownedSpecies: {'chien': true},
    ownedAnimals: ['a1'],
    preferences: {},
    moduleRoles: {},
    createdAt: DateTime(2025, 4, 5),
    updatedAt: DateTime(2025, 4, 5),
  );

  setUp(() {
    mockBox = MockBox<UserModel>();
    when(mockBox.isOpen).thenReturn(true);

    userService = UserService(testBox: mockBox, skipHiveInit: true);
  });

  group('USER_SERVICE - Hive local', () {
    test('updateUserLocally() stocke l\'utilisateur dans Hive', () async {
      when(mockBox.put('current_user', testUser)).thenAnswer((_) async {});
      await userService.updateUserLocally(testUser);
      verify(mockBox.put('current_user', testUser)).called(1);
    });

    test('deleteUserLocally() supprime bien l\'utilisateur', () async {
      when(mockBox.delete('current_user')).thenAnswer((_) async {});
      await userService.deleteUserLocally();
      verify(mockBox.delete('current_user')).called(1);
    });

    test("getUserFromHive() retourne l'utilisateur si présent", () {
      when(mockBox.get('current_user')).thenReturn(testUser);
      final result = userService.getUserFromHive();
      expect(result, isNotNull);
      expect(result!.id, equals('u1'));
    });

    test('updateUser envoie à Firebase et met à jour Hive (mock Firebase)', () async {
      when(mockBox.put(any, any)).thenAnswer((_) async {});
      final success = await userService.updateUser(testUser);
      expect(success, isTrue);
      verify(mockBox.put('current_user', testUser)).called(1);
    });

    test('updateUserFields modifie uniquement les champs fournis', () async {
      when(mockBox.get('current_user')).thenReturn(testUser);
      when(mockBox.put(any, any)).thenAnswer((_) async {});
      await userService.updateUserFields({'name': 'Nouvel utilisateur'});
      verify(mockBox.put(any, any)).called(1);
    });
  });
}
