import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:anisphere/modules/noyau/logic/ia_executor.dart';
import 'package:anisphere/modules/noyau/logic/ia_context.dart';
import 'package:anisphere/modules/noyau/logic/ia_master.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
import 'package:anisphere/modules/noyau/services/notification_service.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';

class MockAnimalService extends Mock implements AnimalService {}

class MockNotificationService extends Mock implements NotificationService {}

class MockModulesService extends Mock implements ModulesService {}

void main() {
  group('IAExecutor', () {
    late MockAnimalService mockAnimalService;
    late MockNotificationService mockNotificationService;
    late MockModulesService mockModulesService;
    late IAExecutor executor;

    setUp(() {
      mockAnimalService = MockAnimalService();
      mockNotificationService = MockNotificationService();
      mockModulesService = MockModulesService();

      executor = IAExecutor(
        iaMaster: IAMaster.instance,
        notificationService: mockNotificationService,
        modulesService: mockModulesService,
        animalService: mockAnimalService,
      );
    });

    test('executeAll trigger sync_animals action', () async {
      final context = const IAContext(
        isOffline: false,
        isFirstLaunch: false,
        hasAnimals: true,
        animalCount: 1,
      );

      when(mockAnimalService.syncAnimalsWithCloud()).thenAnswer((_) async {});

      await executor.executeAll(context);

      verify(mockAnimalService.syncAnimalsWithCloud()).called(1);
      verifyNever(
        mockNotificationService.sendLocalNotification(
          title: anyNamed('title'),
          body: anyNamed('body'),
        ),
      );
    });
  });
}