import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:anisphere/modules/noyau/services/firebase_service.dart';

class FakeFirebaseAuth extends Fake implements FirebaseAuth {}

class FakeFirebaseService extends FirebaseService {
  FakeFirebaseService(FakeFirebaseFirestore firestore)
      : super(firestore: firestore, firebaseAuth: FakeFirebaseAuth());
}

class FailingFirebaseService extends FirebaseService {
  FailingFirebaseService(FakeFirebaseFirestore firestore)
      : super(firestore: firestore, firebaseAuth: FakeFirebaseAuth());

  @override
  Future<void> sendModuleData(String moduleName, Map<String, dynamic> data) async {
    throw Exception('fail');
  }
}
