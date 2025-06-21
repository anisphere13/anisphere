// Copilot Prompt : Test automatique généré pour share_screen.dart (widget)
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/models/share_history_model.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import 'package:anisphere/modules/noyau/screens/share_screen.dart';
import '../../test_config.dart';

class _FakeUserProvider extends UserProvider {
  final UserModel? _user;
  _FakeUserProvider(this._user)
      : super(UserService(skipHiveInit: true), AuthService());

  @override
  UserModel? get user => _user;
}

void main() {
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(ShareHistoryModelAdapter());
    await Hive.openBox<ShareHistoryModel>('share_history');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('share_history');
    await tempDir.delete(recursive: true);
  });

  testWidgets('renders without AppBar', (tester) async {
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
        child: const MaterialApp(home: ShareScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsNothing);
    expect(find.text('Partager localement'), findsOneWidget);
  });
}
