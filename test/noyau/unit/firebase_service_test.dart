import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anisphere/services/firebase_service.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';

import 'firebase_service_test_config.mocks.dart';

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockFirebaseAuth mockAuth;
  late MockCollectionReference<Map<String, dynamic>> mockUserCollection;
  late MockCollectionReference<Map<String, dynamic>> mockAnimalCollection;
  late MockDocumentReference<Map<String, dynamic>> mockUserDoc;
  late FirebaseService firebaseService;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockAuth = MockFirebaseAuth();
    mockUserCollection = MockCollectionReference();
    mockAnimalCollection = MockCollectionReference();
    mockUserDoc = MockDocumentReference();

    when(mockFirestore.collection('users')).thenReturn(mockUserCollection);
    when(mockUserCollection.doc(any)).thenReturn(mockUserDoc);
    when(mockFirestore.collection('animals')).thenReturn(mockAnimalCollection);
    when(mockAnimalCollection.doc(any)).thenReturn(mockUserDoc);

    firebaseService = FirebaseService(firestore: mockFirestore, firebaseAuth: mockAuth);
  });

  test('saveUser() - sauvegarde utilisateur sans erreur', () async {
    final user = UserModel(
      id: 'u1',
      name: 'Jean',
      email: 'jean@example.com',
      phone: '0000',
      profilePicture: '',
      profession: 'dev',
      ownedSpecies: {'chien': true},
      ownedAnimals: ['a1'],
      preferences: {},
      moduleRoles: {},
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    when(mockUserDoc.set(any, any)).thenAnswer((_) async => {});
    final result = await firebaseService.saveUser(user);
    expect(result, true);
  });

  test('deleteUser() - suppression utilisateur avec ID vide', () async {
    final result = await firebaseService.deleteUser('');
    expect(result, false);
  });

  test('saveAnimal() - sauvegarde animal avec ID vide', () async {
    final animal = AnimalModel(
      id: '',
      name: 'Rex',
      species: 'chien',
      breed: 'labrador',
      imageUrl: '',
      ownerId: 'u1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final result = await firebaseService.saveAnimal(animal);
    expect(result, false);
  });
}
