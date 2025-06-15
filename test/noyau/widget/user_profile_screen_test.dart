// Copilot Prompt : Test automatique généré pour user_profile_screen.dart (widget)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:anisphere/modules/noyau/screens/user_profile_screen.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import '../../test_config.dart';
import '../../helpers/test_fakes.dart';

class _TestUserProvider extends UserProvider {
  _TestUserProvider()
      : super(UserService(skipHiveInit: true),
            AuthService(firebaseAuth: FakeFirebaseAuth(), userService: UserService(skipHiveInit: true)));

  @override
  UserModel? get user => const UserModel(
        id: 'u1',
        name: 'Test',
        email: 'test@test.com',
        phone: '',
        profilePicture: '',
        profession: '',
        ownedSpecies: {},
        ownedAnimals: [],
        preferences: {},
        moduleRoles: {},
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
        activeModules: [],
        role: 'user',
        iaPremium: false,
      );
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('displays user name and logout button', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<UserProvider>(
        create: (_) => _TestUserProvider(),
        child: const MaterialApp(home: UserProfileScreen()),
      ),
    );

    expect(find.text('Mon Profil'), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);
    expect(find.text('Se déconnecter'), findsOneWidget);
  });
}
