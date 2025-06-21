// Copilot Prompt : Test automatique généré pour ia_executor.dart (unit)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/logic/ia_executor.dart';
import 'package:anisphere/modules/noyau/logic/ia_master.dart';
import 'package:anisphere/modules/noyau/logic/ia_context.dart';
import 'package:anisphere/modules/noyau/services/notification_service.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
import 'package:anisphere/modules/noyau/logic/ia_flag.dart';

class FakeNotificationService extends NotificationService {
  bool called = false;
  @override
  Future<void> sendLocalNotification({
    required String title,
    required String body,
  }) async {
    called = true;
  }
}

class FakeModulesService extends ModulesService {
  @override
  Future<void> deactivateUnusedModules() async {}
}

class FakeAnimalService extends AnimalService {
  FakeAnimalService() : super(skipHiveInit: true);
  @override
  Future<void> syncAnimalsWithCloud() async {}
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('executeAll triggers notification when needed', () async {
    final notif = FakeNotificationService();
    final executor = IAExecutor(
      iaMaster: IAMaster.test(),
      notificationService: notif,
      modulesService: FakeModulesService(),
      animalService: FakeAnimalService(),
    );

    IAFlag.enableSuggestions = false;
    final ctx = IAContext(
      isOffline: false,
      isFirstLaunch: false,
      hasAnimals: true,
      animalCount: 1,
      lastSyncDate: DateTime.now().subtract(const Duration(days: 366)),
    );
    await executor.executeAll(ctx);
    expect(notif.called, isTrue);
  });
}
