// Copilot Prompt : Test automatique généré pour job_context_helper.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:anisphere/modules/noyau/logic/job_context_helper.dart';
import '../../test_config.dart';

class FakeBattery extends Fake implements Battery {
  final int level;
  FakeBattery(this.level);
  @override
  Future<int> get batteryLevel async => level;
}

class FakeConnectivityPlatform extends ConnectivityPlatform {
  final List<ConnectivityResult> results;
  FakeConnectivityPlatform(this.results);
  @override
  Future<List<ConnectivityResult>> checkConnectivity() async => results;
  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged => Stream.value(results);
}

void main() {
  late Battery previousBattery;
  late Connectivity previousConnectivity;
  late ConnectivityPlatform previousPlatform;

  setUpAll(() async {
    await initTestEnv();
  });

  setUp(() {
    previousBattery = JobContextHelper.battery;
    previousConnectivity = JobContextHelper.connectivity;
    previousPlatform = ConnectivityPlatform.instance;
  });

  tearDown(() {
    JobContextHelper.battery = previousBattery;
    JobContextHelper.connectivity = previousConnectivity;
    ConnectivityPlatform.instance = previousPlatform;
  });

  test('batteryLevel returns mocked value', () async {
    JobContextHelper.battery = FakeBattery(80);
    final level = await JobContextHelper.batteryLevel();
    expect(level, 80);
  });

  test('connectivityState returns mocked wifi', () async {
    ConnectivityPlatform.instance = FakeConnectivityPlatform([ConnectivityResult.wifi]);
    JobContextHelper.connectivity = Connectivity();
    final results = await JobContextHelper.connectivityState();
    expect(results, [ConnectivityResult.wifi]);
  });

  test('isIdleNightTime true for 23h', () {
    final t = DateTime(2023, 1, 1, 23);
    expect(JobContextHelper.isIdleNightTime(t), isTrue);
  });

  test('isIdleNightTime false for noon', () {
    final t = DateTime(2023, 1, 1, 12);
    expect(JobContextHelper.isIdleNightTime(t), isFalse);
  });
}
