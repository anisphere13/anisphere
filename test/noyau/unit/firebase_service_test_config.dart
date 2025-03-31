// test/noyau/unit/firebase_service_test_config.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  FirebaseFirestore,
  FirebaseAuth,
  CollectionReference,
  DocumentReference,
])
void main() {}
