import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:anisphere/modules/noyau/services/sharing_connectivity_manager.dart';
import '../../test_config.dart';

class FakeConnectivityPlatform extends ConnectivityPlatform {
  final List<ConnectivityResult> results;
  FakeConnectivityPlatform(this.results);
  @override
  Future<List<ConnectivityResult>> checkConnectivity() async => results;
  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged => Stream.value(results);
}

void main() {
  late ConnectivityPlatform previous;

  setUp(() async {
    await initTestEnv();
    previous = ConnectivityPlatform.instance;
  });

  tearDown(() {
    ConnectivityPlatform.instance = previous;
  });

  test('wifi connectivity sets cloudReady mode', () async {
    ConnectivityPlatform.instance = FakeConnectivityPlatform([ConnectivityResult.wifi]);
    final manager = SharingConnectivityManager();
    await manager.init();
    expect(manager.mode, SharingMode.cloudReady);
    manager.dispose();
  });

  test('no connectivity sets offline mode', () async {
    ConnectivityPlatform.instance = FakeConnectivityPlatform([ConnectivityResult.none]);
    final manager = SharingConnectivityManager();
    await manager.init();
    expect(manager.mode, SharingMode.offline);
    manager.dispose();
  });
}
