// Copilot Prompt : Test automatique généré pour login_screen.dart (widget)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:anisphere/modules/noyau/screens/login_screen.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import '../../test_config.dart';
import '../../helpers/test_fakes.dart';

class _FakeAuthService extends AuthService {
  _FakeAuthService() : super(firebaseAuth: FakeFirebaseAuth(), userService: UserService(skipHiveInit: true));

  @override
  Future<bool> verifyBiometric() async => true;
}

class _FakeUserProvider extends UserProvider {
  _FakeUserProvider() : super(UserService(skipHiveInit: true), _FakeAuthService());
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('renders form and buttons', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<UserProvider>(
        create: (_) => _FakeUserProvider(),
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    expect(find.text('Connexion'), findsWidgets);
    expect(find.text('Créer un compte'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
  });
}
