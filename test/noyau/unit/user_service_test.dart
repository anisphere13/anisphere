// 📁 test/noyau/unit/user_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';

import 'user_service_test.mocks.dart';

@GenerateMocks([
  Box,
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
])
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

    test('updateUserFields modifie uniquement les champs fournis', () async {
      when(mockBox.get('current_user')).thenReturn(testUser);
      when(mockBox.put('current_user', any)).thenAnswer((_) async {});
      await userService.updateUserFields({'name': 'Nouvel utilisateur'});
      verify(mockBox.put('current_user', any)).called(1);
    });
  });

  group('USER_SERVICE - Firebase + Hive', () {
    test('updateUser() met à jour Firebase + Hive', () async {
      final mockFirestore = MockFirebaseFirestore();
      final mockCollection = MockCollectionReference<Map<String, dynamic>>();
      final mockDoc = MockDocumentReference<Map<String, dynamic>>();

      final updatedService = UserService(
        firestore: mockFirestore,
        testBox: mockBox,
        skipHiveInit: true,
      );

      when(mockFirestore.collection('users')).thenReturn(mockCollection);
      when(mockCollection.doc(testUser.id)).thenReturn(mockDoc);
      when(mockDoc.set(testUser.toJson(), SetOptions(merge: true)))
          .thenAnswer((_) async {});
      when(mockBox.put('current_user', testUser)).thenAnswer((_) async {});

      final result = await updatedService.updateUser(testUser);

      expect(result, isTrue);
      verify(mockFirestore.collection('users')).called(1);
      verify(mockCollection.doc(testUser.id)).called(1);
      verify(mockDoc.set(testUser.toJson(), SetOptions(merge: true))).called(1);
      verify(mockBox.put('current_user', testUser)).called(1);
    });
  });
}
