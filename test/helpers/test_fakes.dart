import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:anisphere/modules/noyau/services/firebase_service.dart';

typedef FakeFirestore = FakeFirebaseFirestore;

class FakeFirebaseAuth extends Fake implements FirebaseAuth {}

class FakeFirebaseService extends FirebaseService {
  FakeFirebaseService(FakeFirestore firestore)
      : super(firestore: firestore, firebaseAuth: FakeFirebaseAuth());
}
