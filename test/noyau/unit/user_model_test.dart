import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';

void main() {
  group('USER_MODEL - Test unitaire', () {
    test("Création d'un utilisateur valide", () {
      final user = UserModel(
        id: 'u1',
        name: 'Jean',
        email: 'jean@mail.com',
        phone: '0123456789',
        profilePicture: '',
        profession: 'éleveur',
        ownedSpecies: {'chien': true},
        ownedAnimals: ['a1', 'a2'],
        preferences: {'darkMode': true},
        moduleRoles: {'sante': 'veto'},
        createdAt: DateTime(2023, 1, 1),
        updatedAt: DateTime(2023, 1, 1),
      );

      expect(user.name, equals('Jean'));
      expect(user.profession, isNotEmpty);
      expect(user.ownedAnimals.length, equals(2));
    });

    test("Conversion toJson / fromJson", () {
      final user = UserModel(
        id: 'u2',
        name: 'Laura',
        email: 'laura@mail.com',
        phone: '0987654321',
        profilePicture: '',
        profession: 'particulier',
        ownedSpecies: {'chat': true},
        ownedAnimals: ['a3'],
        preferences: {'notifications': false},
        moduleRoles: {'education': 'utilisateur'},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final map = user.toJson();
      final clone = UserModel.fromJson(map);

      expect(clone.name, equals(user.name));
      expect(clone.email, equals(user.email));
      expect(clone.ownedAnimals.length, equals(1));
    });

    test('copyWith modifie uniquement les champs spécifiés', () {
      final user = UserModel(
        id: 'u1',
        name: 'Zoe',
        email: 'zoe@mail.com',
        phone: '0000',
        profilePicture: '',
        profession: 'soigneur',
        ownedSpecies: {},
        ownedAnimals: [],
        preferences: {},
        moduleRoles: {},
        createdAt: DateTime(2025, 1, 1),
        updatedAt: DateTime(2025, 1, 1),
      );

      final updated = user.copyWith(name: 'Léo');

      expect(updated.name, equals('Léo'));
      expect(updated.email, equals('zoe@mail.com'));
      expect(updated.id, equals('u1'));
    });

    test('updateTimestamp met à jour updatedAt à maintenant', () {
      final user = UserModel(
        id: 'u1',
        name: 'Test',
        email: 't@t.com',
        phone: '0000',
        profilePicture: '',
        profession: 'na',
        ownedSpecies: {},
        ownedAnimals: [],
        preferences: {},
        moduleRoles: {},
        createdAt: DateTime(2025, 1, 1),
        updatedAt: DateTime(2025, 1, 1),
      );

      final before = user.updatedAt;
      user.updateTimestamp();
      final after = user.updatedAt;

      expect(after.isAfter(before), isTrue);
    });
  });
}
