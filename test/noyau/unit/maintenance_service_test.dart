// Copilot Prompt : Test automatique généré pour maintenance_service.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/services/maintenance_service.dart';
import 'package:anisphere/modules/noyau/logic/ia_master.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('runStartupChecks calls cleanOldLogs', () async {
    bool called = false;
    class FakeMaster extends IAMaster {
      FakeMaster() : super.test();
      @override
      Future<void> cleanOldLogs() async {
        called = true;
      }
    }

    final service = MaintenanceService(ia: FakeMaster());
    await service.runStartupChecks();
    expect(called, isTrue);
  });
}
