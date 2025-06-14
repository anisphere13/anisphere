import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/models/consent_entry.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/providers/consent_provider.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/screens/legal_screen.dart';
import 'package:anisphere/modules/noyau/services/consent_service.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';

class _TestConsentProvider extends ConsentProvider {
  ConsentAction? last;
  _TestConsentProvider(ConsentService service) : super(service: service);
  @override
  Future<void> addAction(ConsentAction action, String userId) async {
    last = action;
  }
}

class _TestUserProvider extends UserProvider {
  final UserModel? _testUser;
  _TestUserProvider(this._testUser)
      : super(UserService(skipHiveInit: true), AuthService());
  @override
  UserModel? get user => _testUser;
}

void main() {
  late Directory tempDir;
  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(ConsentEntryAdapter());
    Hive.registerAdapter(ConsentActionAdapter());
    await Hive.openBox<ConsentEntry>('consent_history');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('consent_history');
    await tempDir.delete(recursive: true);
  });

  testWidgets('accept button records consent', (tester) async {
    final service = ConsentService(
      testBox: Hive.box<ConsentEntry>('consent_history'),
      skipHiveInit: true,
    );
    final consentProvider = _TestConsentProvider(service);
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
    final userProvider = _TestUserProvider(user);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>.value(value: userProvider),
          ChangeNotifierProvider<ConsentProvider>.value(value: consentProvider),
        ],
        child: const MaterialApp(home: LegalScreen()),
      ),
    );

    await tester.tap(find.text('Accepter'));
    await tester.pumpAndSettle();

    expect(consentProvider.last, ConsentAction.accepted);
  });
}
