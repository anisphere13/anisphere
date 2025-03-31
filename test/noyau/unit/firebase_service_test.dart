import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'firebase_service_test.mocks.dart';

@GenerateMocks([FirebaseFirestore, CollectionReference, DocumentReference])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FIREBASE_SERVICE - Tests unitaires', () {
    late FirebaseService service;
    late MockFirebaseFirestore mockFirestore;
    late MockCollectionReference mockCollection;
    late MockDocumentReference mockDocument;

    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      mockCollection = MockCollectionReference();
      mockDocument = MockDocumentReference();

      when(mockFirestore.collection(any)).thenReturn(mockCollection);
      when(mockCollection.doc(any)).thenReturn(mockDocument);

      service = FirebaseService(firestore: mockFirestore);
    });

    test('Récupère la collection', () {
      final result = service.getCollection('utilisateurs');
      expect(result, isA<CollectionReference>());
    });

    test('Récupère le document', () {
      final result = service.getDocument('utilisateurs', '123');
      expect(result, isA<DocumentReference>());
    });
  });
}
