import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:anisphere/modules/noyau/services/firebase_service.dart';
class FakeFirebaseAuth extends Fake implements FirebaseAuth {}

class FakeFirestore extends Fake implements FirebaseFirestore {
  FakeFirestore({this.fail = false});
  final bool fail;
  final Map<String, Map<String, Map<String, dynamic>>> data = {};

  @override
  CollectionReference<Map<String, dynamic>> collection(String path) {
    data.putIfAbsent(path, () => {});
    return _FakeCollection(data[path]!, fail);
  }
}

class _FakeCollection extends Fake implements CollectionReference<Map<String, dynamic>> {
  _FakeCollection(this._map, this.fail);
  final Map<String, Map<String, dynamic>> _map;
  final bool fail;

  @override
  DocumentReference<Map<String, dynamic>> doc([String? id]) {
    return _FakeDoc(_map, id ?? '', fail);
  }
}

class _FakeDoc extends Fake implements DocumentReference<Map<String, dynamic>> {
  _FakeDoc(this._map, this.id, this.fail);
  final Map<String, Map<String, dynamic>> _map;
  @override
  final String id;
  final bool fail;

  @override
  Future<void> set(Map<String, dynamic> data, [SetOptions? options]) async {
    if (fail) throw Exception('fail');
    _map[id] = data;
  }
}


class FakeFirebaseService extends FirebaseService {
  FakeFirebaseService(FakeFirestore firestore)
      : super(firestore: firestore, firebaseAuth: FakeFirebaseAuth());
}
