// Copilot Prompt : Test automatique généré pour maintenance_service.dart (unit)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/services/maintenance_service.dart';
import 'package:anisphere/modules/noyau/logic/ia_master.dart';

class FakeMaster extends IAMaster {
  FakeMaster() : super.test();
  bool called = false;
  @override
  Future<void> cleanOldLogs() async {
    called = true;
  }
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('runStartupChecks calls cleanOldLogs', () async {
    final ia = FakeMaster();
    final service = MaintenanceService(ia: ia);
    await service.runStartupChecks();
    expect(ia.called, isTrue);
  });
}
