// Copilot Prompt : Test automatique généré pour auth_service.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import '../../helpers/test_fakes.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('currentUser is null with FakeFirebaseAuth', () {
    final service = AuthService(
      firebaseAuth: FakeFirebaseAuth(),
      userService: UserService(skipHiveInit: true, firestore: FakeFirestore()),
    );
    expect(service.currentUser, isNull);
  });
}
