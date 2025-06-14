import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:anisphere/modules/noyau/services/sharing_connectivity_manager.dart';
import 'package:anisphere/modules/noyau/services/sharing_ia_optimizer.dart';
import 'package:anisphere/modules/noyau/services/cloud_sharing_service.dart';
import 'package:anisphere/modules/noyau/services/local_sharing_service.dart';
import '../../test_config.dart';

class FakeConnectivityPlatform extends ConnectivityPlatform {
  final List<ConnectivityResult> results;
  FakeConnectivityPlatform(this.results);
  @override
  Future<List<ConnectivityResult>> checkConnectivity() async => results;
  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged => Stream.value(results);
}

class FakeCloudSharingService extends CloudSharingService {
  final List<List<int>> uploads = [];
  FakeCloudSharingService() : super();
  @override
  Future<void> uploadCompressed(List<int> gzipData) async {
    uploads.add(gzipData);
  }
}

void main() {
  late Directory tempDir;
  late ConnectivityPlatform previous;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    previous = ConnectivityPlatform.instance;
  });

  tearDown(() async {
    ConnectivityPlatform.instance = previous;
    await Hive.deleteBoxFromDisk('local_sharing_queue');
    await tempDir.delete(recursive: true);
  });

  test('optimizer uploads data when cloudReady', () async {
    ConnectivityPlatform.instance = FakeConnectivityPlatform([ConnectivityResult.wifi]);
    final cloud = FakeCloudSharingService();
    final connectivity = SharingConnectivityManager();
    final optimizer = SharingIaOptimizer(
      cloudService: cloud,
      connectivity: connectivity,
    );
    await optimizer.init();
    await optimizer.addData({'k': 'v'});
    await Future.delayed(const Duration(milliseconds: 100));
    expect(cloud.uploads.length, 1);
    optimizer.dispose();
  });

  test('optimizer ignores duplicate data', () async {
    ConnectivityPlatform.instance = FakeConnectivityPlatform([ConnectivityResult.wifi]);
    final cloud = FakeCloudSharingService();
    final optimizer = SharingIaOptimizer(cloudService: cloud);
    await optimizer.init();
    await optimizer.addData({'a': 1});
    await optimizer.addData({'a': 1});
    await Future.delayed(const Duration(milliseconds: 100));
    expect(cloud.uploads.length, 1);
    optimizer.dispose();
  });
}
