import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';

@GenerateMocks([
  FirebaseAuth,
  UserCredential,
  User,
  UserService,
  GoogleSignIn,
  GoogleSignInAccount,
  GoogleSignInAuthentication,
  AuthorizationCredentialAppleID,
])
void main() {}
