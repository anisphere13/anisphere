import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/screens/share_screen.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import '../../test_config.dart';
import '../../helpers/test_fakes.dart';

class _TestAuthService extends AuthService {
  _TestAuthService() : super(firebaseAuth: FakeFirebaseAuth(), userService: UserService(skipHiveInit: true));
  @override
  Future<bool> verifyBiometric() async => true;
}

class _TestUserProvider extends UserProvider {
  _TestUserProvider() : super(UserService(skipHiveInit: true), _TestAuthService());
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('tapping export shows snackbar', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<UserProvider>(
        create: (_) => _TestUserProvider(),
        child: const MaterialApp(home: ShareScreen()),
      ),
    );

    await tester.tap(find.text('Exporter mes données'));
    await tester.pump();

    expect(find.text('Export IA à venir'), findsOneWidget);
  });
}
