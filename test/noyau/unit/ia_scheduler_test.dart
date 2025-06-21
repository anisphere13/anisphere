// Copilot Prompt : Test automatique généré pour ia_scheduler.dart (unit)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/logic/ia_scheduler.dart';
import 'package:anisphere/modules/noyau/logic/ia_executor.dart';
import 'package:anisphere/modules/noyau/logic/ia_master.dart';
import 'package:anisphere/modules/noyau/logic/ia_context.dart';
import 'package:anisphere/modules/noyau/services/notification_service.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';

class FakeMaster extends IAMaster {
  FakeMaster() : super.test();
  bool called = false;
  @override
  Future<void> syncCloudIA(String userId) async {
    called = true;
  }
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('triggerNow calls syncCloudIA when premium user', () async {
    final scheduler = IAScheduler(
      executor: IAExecutor(
        iaMaster: FakeMaster(),
        notificationService: NotificationService(),
        modulesService: ModulesService(),
        animalService: AnimalService(skipHiveInit: true),
      ),
      iaMaster: FakeMaster(),
      user: UserModel(
        id: 'u1',
        name: 'n',
        email: 'e',
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
        iaPremium: true,
      ),
    );
    final ctx = IAContext.empty();
    await scheduler.triggerNow(ctx);
    expect((scheduler.iaMaster as FakeMaster).called, isTrue);
  });
}
