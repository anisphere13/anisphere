// Copilot Prompt : Test automatique généré pour gps_provider.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/providers/gps_provider.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('initial state is disconnected', () {
    final provider = GpsProvider();
    expect(provider.isConnected, isFalse);
    expect(provider.positionStream, isNotNull);
  });
}
