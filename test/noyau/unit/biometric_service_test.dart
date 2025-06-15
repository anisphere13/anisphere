// Copilot Prompt : Test automatique généré pour biometric_service.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/services/biometric_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mockito/mockito.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('canCheckBiometrics returns false with fake auth', () async {
    class FakeAuth extends Fake implements LocalAuthentication {
      @override
      Future<bool> get canCheckBiometrics async => false;
    }

    final service = BiometricService(auth: FakeAuth());
    final result = await service.canCheckBiometrics();
    expect(result, isFalse);
  });
}
