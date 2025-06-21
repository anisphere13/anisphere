import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anisphere/modules/noyau/services/firebase_service.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/noyau/models/photo_model.dart';
import '../../test_config.dart';
import '../../helpers/test_fakes.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late FakeFirestore firestore;
  late FirebaseService service;

  setUpAll(() async {
    await initTestEnv();
  });

  setUp(() {
    firestore = FakeFirestore();
    service = FirebaseService(
      firestore: firestore,
      firebaseAuth: FakeFirebaseAuth(),
    );
  });

  test('signOut calls FirebaseAuth.signOut', () async {
    final mockAuth = MockFirebaseAuth();
    final s = FirebaseService(firestore: firestore, firebaseAuth: mockAuth);

    await s.signOut();

    verify(mockAuth.signOut()).called(1);
  });

  test('saveUser stores user in Firestore', () async {
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

    final ok = await service.saveUser(user);
    expect(ok, isTrue);
    final doc = await firestore.collection('users').doc('u1').get();
    expect(doc.data()?['email'], 't@test.com');

    await service.saveUser(user, forTraining: true);
    final docTrain =
        await firestore.collection('training_users').doc('u1').get();
    expect(docTrain.exists, isTrue);
  });

  test('getUser retrieves user from Firestore', () async {
    final user = UserModel(
      id: 'u2',
      name: 'Name',
      email: 'n@test.com',
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
    await firestore.collection('users').doc('u2').set(user.toJson());

    final fetched = await service.getUser('u2');
    expect(fetched?.email, 'n@test.com');
  });

  test('deleteUser removes user from Firestore', () async {
    await firestore.collection('users').doc('u3').set({'id': 'u3'});

    final ok = await service.deleteUser('u3');
    expect(ok, isTrue);
    final doc = await firestore.collection('users').doc('u3').get();
    expect(doc.exists, isFalse);
  });

  test('saveAnimal stores animal in Firestore', () async {
    final animal = AnimalModel(
      id: 'a1',
      name: 'Rex',
      species: 'dog',
      breed: '',
      imageUrl: '',
      ownerId: 'u1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final ok = await service.saveAnimal(animal);
    expect(ok, isTrue);
    final doc = await firestore.collection('animals').doc('a1').get();
    expect(doc.data()?['name'], 'Rex');

    await service.saveAnimal(animal, forTraining: true);
    final docTrain =
        await firestore.collection('training_animals').doc('a1').get();
    expect(docTrain.exists, isTrue);
  });

  test('getAnimal retrieves animal from Firestore', () async {
    final animal = AnimalModel(
      id: 'a2',
      name: 'Cat',
      species: 'cat',
      breed: '',
      imageUrl: '',
      ownerId: 'u1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await firestore.collection('animals').doc('a2').set(animal.toJson());

    final fetched = await service.getAnimal('a2');
    expect(fetched?.species, 'cat');
  });

  test('deleteAnimal removes animal from Firestore', () async {
    await firestore.collection('animals').doc('a3').set({'id': 'a3'});

    final ok = await service.deleteAnimal('a3');
    expect(ok, isTrue);
    final doc = await firestore.collection('animals').doc('a3').get();
    expect(doc.exists, isFalse);
  });

  test('getAllAnimals filters by ownerId', () async {
    final a1 = AnimalModel(
      id: 'ax1',
      name: 'ax1',
      species: 'dog',
      breed: '',
      imageUrl: '',
      ownerId: 'o1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final a2 = a1.copyWith(id: 'ax2', ownerId: 'o2');
    await firestore.collection('animals').doc('ax1').set(a1.toJson());
    await firestore.collection('animals').doc('ax2').set(a2.toJson());

    final filtered = await service.getAllAnimals(ownerId: 'o1');
    expect(filtered.length, 1);
    expect(filtered.first.id, 'ax1');

    final all = await service.getAllAnimals();
    expect(all.length, 2);
  });

  test('savePhoto stores photo in Firestore', () async {
    final photo = PhotoModel(
      id: 'p1',
      userId: 'u1',
      animalId: 'a1',
      localPath: '/tmp/1.png',
      createdAt: DateTime.now(),
      uploaded: false,
      remoteUrl: '',
    );

    final ok = await service.savePhoto(photo);
    expect(ok, isTrue);
    final doc = await firestore.collection('photos').doc('p1').get();
    expect(doc.data()?['animalId'], 'a1');
  });

  test('sendModuleData writes to training_modules collection', () async {
    await service.sendModuleData('demo', {'v': 1});
    final docs = await firestore.collection('training_modules').get();
    expect(docs.docs.length, 1);
  });

  test('sendIAFeedback stores metrics', () async {
    await service.sendIAFeedback({'score': 2});
    final docs = await firestore.collection('ia_feedback').get();
    expect(docs.docs.length, 1);
  });

  test('sendNotificationFeedback stores feedback', () async {
    await service.sendNotificationFeedback({'id': 'n1'});
    final docs = await firestore.collection('notification_feedback').get();
    expect(docs.docs.length, 1);
    expect(docs.docs.first.data()['id'], 'n1');
  });
}
