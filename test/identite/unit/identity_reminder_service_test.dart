import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/identite/services/identity_reminder_service.dart';
import 'package:anisphere/modules/noyau/logic/ia_master.dart';

class FakeIAMaster extends IAMaster {
  final List<String> logs = [];

  FakeIAMaster() : super.test();
  void logEvent({required String channel, required String message, String? suggestion}) {
    logs.add(message);
  }
}

void main() {
  test('déclenche un rappel IA après 12 mois', () {
    final ia = FakeIAMaster();
    final service = IdentityReminderService(iaMaster: ia);
    final model = IdentityModel(
      animalId: 'abc123',
      lastUpdate: DateTime.now().subtract(const Duration(days: 370)),
    );

    service.checkIdentityAndNotify(model);
    expect(ia.logs.isNotEmpty, isTrue);
  });
}
