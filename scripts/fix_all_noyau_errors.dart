import 'dart:io';

void main() async {
  await _fixUserModel();
  await _fixAuthService();
  await _createMockBuilder();
  stderr.writeln('\n✅ Tous les correctifs ont été appliqués. Tu peux relancer build_runner puis les tests.');
}

Future<void> _fixUserModel() async {
  final path = 'lib/modules/noyau/models/user_model.dart';
  final file = File(path);
  if (!file.existsSync()) return stderr.writeln('❌ Fichier introuvable : $path');

  final original = await file.readAsString();
  final corrected = original.replaceFirst(RegExp(r'const\s+UserModel\s*\('), 'UserModel(');

  if (corrected != original) {
    await file.writeAsString(corrected);
    stderr.writeln('🔧 user_model.dart : suppression du constructeur const');
  } else {
    stderr.writeln('✅ user_model.dart : déjà corrigé');
  }
}

Future<void> _fixAuthService() async {
  final path = 'lib/modules/noyau/services/auth_service.dart';
  final file = File(path);
  if (!file.existsSync()) return stderr.writeln('❌ Fichier introuvable : $path');

  var content = await file.readAsString();

  // Corrige les erreurs appleIdCredential mal nommé
  content = content.replaceAll('appleIdCredential.', 'appleCredential.');

  await file.writeAsString(content);
  stderr.writeln('🔧 auth_service.dart : correction appleCredential');
}

Future<void> _createMockBuilder() async {
  final path = 'test/noyau/unit/auth_service_test.mocks_builder.dart';
  final file = File(path);

  if (file.existsSync()) {
    stderr.writeln('✅ Fichier de mocks déjà présent.');
    return;
  }

  const content = '''
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
''';

  await file.writeAsString(content);
  stderr.writeln('🧪 auth_service_test.mocks_builder.dart : générateur de mocks créé');
}
