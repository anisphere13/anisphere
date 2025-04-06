// 📁 test/noyau/unit/auth_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:anisphere/modules/noyau/services/auth_service.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'auth_service_test.mocks.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockUserService mockUserService;
  late AuthService authService;

  const fakeUid = 'u123';
  const fakeEmail = 'test@mail.com';
  const fakePassword = 'secure123';

  final fakeUserModel = UserModel(
    id: fakeUid,
    name: 'Test User',
    email: fakeEmail,
    phone: '0600000000',
    profilePicture: '',
    profession: 'dresseur',
    ownedSpecies: {'chien': true},
    ownedAnimals: ['a1'],
    preferences: {},
    moduleRoles: {},
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    mockUserService = MockUserService();

    when(mockUser.uid).thenReturn(fakeUid);
    when(mockUserCredential.user).thenReturn(mockUser);

    authService = AuthService(
      firebaseAuth: mockFirebaseAuth,
      userService: mockUserService,
    );
  });

  group('AUTH_SERVICE - Tests unitaires', () {
    test('signInWithEmail renvoie un UserModel si tout est OK', () async {
      // Arrange
      when(mockFirebaseAuth.currentUser).thenReturn(null);
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: fakeEmail,
        password: fakePassword,
      )).thenAnswer((_) async => mockUserCredential);

      when(mockUserService.getUserFromFirebase(fakeUid))
          .thenAnswer((_) async => fakeUserModel);

      // Act
      final result =
          await authService.signInWithEmail(fakeEmail, fakePassword);

      // Assert
      expect(result, isNotNull);
      expect(result!.email, equals(fakeEmail));
      verify(mockUserService.getUserFromFirebase(fakeUid)).called(1);
    });

    test('signInWithEmail retourne null si Firebase échoue', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(null);
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: fakeEmail,
        password: fakePassword,
      )).thenThrow(FirebaseAuthException(code: 'invalid-credentials'));

      final result =
          await authService.signInWithEmail(fakeEmail, fakePassword);

      expect(result, isNull);
    });

    test('signOut appelle FirebaseAuth.signOut et UserService.deleteUserFromHive', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn(fakeUid);
      when(mockUserService.deleteUserFromHive(fakeUid)).thenAnswer((_) async {});

      await authService.signOut();

      verify(mockFirebaseAuth.signOut()).called(1);
      verify(mockUserService.deleteUserFromHive(fakeUid)).called(1);
    });
  });
}
