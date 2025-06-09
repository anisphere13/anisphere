import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/models/support_ticket_model.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/providers/support_provider.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/screens/support_screen.dart';
import 'package:anisphere/modules/noyau/services/support_service.dart';
import 'package:anisphere/modules/noyau/services/offline_sync_queue.dart';

import "../../helpers/test_fakes.dart";

class _TestSupportProvider extends SupportProvider {
  _TestSupportProvider(SupportService service) : super(service: service);
  SupportTicketModel? added;
  @override
  Future<void> addFeedback(SupportTicketModel feedback) async {
    added = feedback;
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
    Hive.registerAdapter(SupportTicketModelAdapter());
    Hive.registerAdapter(SyncTaskAdapter());
    await Hive.openBox<SupportTicketModel>('support_data');
    await Hive.openBox<SyncTask>('offline_sync_queue');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('support_data');
    await Hive.deleteBoxFromDisk('offline_sync_queue');
    await tempDir.delete(recursive: true);
  });

  testWidgets('submits ticket using provider', (tester) async {
    final service = SupportService(
      firebaseService: FakeFirebaseService(FakeFirestore()),
      skipHiveInit: true,
      testBox: Hive.box<SupportTicketModel>('support_data'),
    );
    final supportProvider = _TestSupportProvider(service);
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
          ChangeNotifierProvider<SupportProvider>.value(value: supportProvider),
        ],
        child: const MaterialApp(home: SupportScreen()),
      ),
    );

    await tester.enterText(find.byType(TextField), 'hello');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(supportProvider.added?.message, 'hello');
  });
}
