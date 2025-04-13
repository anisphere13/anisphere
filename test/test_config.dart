import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> initTestEnv() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}
