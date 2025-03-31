// 📁 test/noyau/unit/user_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';

// 🔧 Mock personnalisé pour Hive
class MockUserBox extends Mock implements Box<UserModel> {}

void main() {
  late MockUserBox mockBox;
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
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  setUp(() {
    mockBox = MockUserBox();
    userService = UserService(testBox: mockBox);
  });

  test('updateUserLocally() stocke l\'utilisateur dans Hive', () async {
    when(mockBox.put('current_user', testUser)).thenAnswer((_) async => {});

    await userService.updateUserLocally(testUser);

    verify(mockBox.put('current_user', testUser)).called(1);
  });

  test('deleteUserLocally() supprime bien l\'utilisateur', () async {
    when(mockBox.delete('current_user')).thenAnswer((_) async => {});

    await userService.deleteUserLocally();

    verify(mockBox.delete('current_user')).called(1);
  });

  test("getUserFromHive() retourne l'utilisateur si présent", () {
    when(mockBox.get('current_user')).thenReturn(testUser);

    final result = userService.getUserFromHive();

    expect(result, isNotNull);
    expect(result!.id, equals(testUser.id));
  });
}
