// Copilot Prompt : Test automatique généré pour animal_form_screen.dart (widget)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:anisphere/modules/noyau/screens/animal_form_screen.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import '../../test_config.dart';

class _FakeUserProvider extends UserProvider {
  final UserModel? _user;
  _FakeUserProvider(this._user)
      : super(UserService(skipHiveInit: true), AuthService());

  @override
  UserModel? get user => _user;
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('renders fields and submit button', (tester) async {
    final user = UserModel(
      id: 'u1',
      name: 'Test',
      email: 't@test.com',
      phone: '',
      profilePicture: '',
      profession: '',
      ownedSpecies: const {},
      ownedAnimals: const [],
      preferences: const {},
      moduleRoles: const {},
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      activeModules: const [],
      role: 'user',
      iaPremium: false,
    );

    await tester.pumpWidget(
      ChangeNotifierProvider<UserProvider>.value(
        value: _FakeUserProvider(user),
        child: const MaterialApp(home: AnimalFormScreen()),
      ),
    );

    expect(find.text('Nom de l’animal'), findsOneWidget);
    expect(find.text('Ajouter'), findsOneWidget);
  });
}
