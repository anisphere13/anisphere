// 📁 test/noyau/unit/auth_provider_test.dart

import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:hive/hive.dart';

import 'package:anisphere/modules/noyau/services/user_service.dart';

@GenerateMocks([
  FirebaseAuth,
  UserCredential,
  User,
  GoogleSignIn,
  GoogleSignInAccount,
  GoogleSignInAuthentication,
  AuthorizationCredentialAppleID,
  UserService,
  Box
])
void main() {}