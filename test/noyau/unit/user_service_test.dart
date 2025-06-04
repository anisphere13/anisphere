// 📄 test/noyau/unit/user_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';

import 'user_service_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  DocumentReference,
  DocumentSnapshot,
  CollectionReference,
  Box,
])
void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockDocumentSnapshot<Map<String, dynamic>> mockSnapshot;
  late MockDocumentReference<Map<String, dynamic>> mockDocRef;
  late MockCollectionReference<Map<String, dynamic>> mockCollection;
  late MockBox<UserModel> mockBox;
  late UserService userService;

  const fakeUid = 'u001';

  final fakeUser = UserModel(
    id: fakeUid,
    name: 'Test',
    email: 'test@mail.com',
    phone: '',
    profilePicture: '',
    profession: '',
    ownedSpecies: {},
    ownedAnimals: [],
    preferences: {},
    moduleRoles: {},
    createdAt: DateTime(2024, 1, 1),
    updatedAt: DateTime(2024, 1, 2),
    activeModules: [],
    role: 'user',
    iaPremium: false,
  );

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();
    mockDocRef = MockDocumentReference<Map<String, dynamic>>();
    mockCollection = MockCollectionReference<Map<String, dynamic>>();
    mockBox = MockBox<UserModel>();

    when(mockBox.isOpen).thenReturn(true);

    userService = UserService(
      firestore: mockFirestore,
      testBox: mockBox,
      skipHiveInit: true,
    );
  });

  group('USER_SERVICE - Hive local', () {
    test('updateUserLocally() stocke l\'utilisateur dans Hive', () async {
      await userService.updateUserLocally(fakeUser);
      verify(mockBox.put(UserService.currentUserKey, fakeUser)).called(1);
    });

    test('deleteUserLocally() supprime bien l\'utilisateur', () async {
      await userService.deleteUserLocally();
      verify(mockBox.delete(UserService.currentUserKey)).called(1);
    });

    test('getUserFromHive() retourne un utilisateur', () {
      when(mockBox.get(UserService.currentUserKey)).thenReturn(fakeUser);
      final user = userService.getUserFromHive();
      expect(user, equals(fakeUser));
    });
  });

  group('USER_SERVICE - Firebase', () {
    test('getUserFromFirebase() retourne un UserModel et le sauvegarde localement', () async {
      when(mockFirestore.collection('users')).thenReturn(mockCollection);
      when(mockCollection.doc(fakeUid)).thenReturn(mockDocRef);
      when(mockDocRef.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.exists).thenReturn(true);
      when(mockSnapshot.data()).thenReturn(fakeUser.toJson());

      when(mockBox.put(any<String>(), any<UserModel>()))
          .thenAnswer((_) async => null);
      final user = await userService.getUserFromFirebase(fakeUid);
      expect(user, isNotNull);
      expect(user!.id, equals(fakeUid));
      verify(mockBox.put(UserService.currentUserKey, any)).called(1);
    });

    test('updateUser() met à jour dans Firebase + Hive', () async {
      when(mockFirestore.collection('users')).thenReturn(mockCollection);
      when(mockCollection.doc(fakeUid)).thenReturn(mockDocRef);
      when(mockDocRef.set(any<Map<String, dynamic>>(), any<SetOptions>()))
          .thenAnswer((_) async => null);
      when(mockBox.put(any<String>(), any<UserModel>()))
          .thenAnswer((_) async => null);

      final success = await userService.updateUser(fakeUser);
      expect(success, isTrue);
      verify(mockBox.put(UserService.currentUserKey, fakeUser)).called(1);
    });
  });

  group('USER_SERVICE - Modules', () {
    test('activateModule() ajoute le module dans la liste', () async {
      const testModule = 'dressage';
      final userWithModule = fakeUser.copyWith(activeModules: [testModule]);

      when(mockBox.get(UserService.currentUserKey)).thenReturn(fakeUser);
      when(mockFirestore.collection('users')).thenReturn(mockCollection);
      when(mockCollection.doc(fakeUid)).thenReturn(mockDocRef);
      when(mockDocRef.set(any<Map<String, dynamic>>(), any<SetOptions>()))
          .thenAnswer((_) async => null);
      when(mockBox.put(any<String>(), any<UserModel>()))
          .thenAnswer((_) async => null);

      await userService.activateModule(testModule);
      verify(mockBox.put(UserService.currentUserKey, userWithModule)).called(1);
    });
  });
}
