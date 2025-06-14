import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/services/cloud_sharing_service.dart';
import 'package:anisphere/modules/noyau/services/cloud_drive_service.dart';
import 'package:anisphere/modules/noyau/services/premium_sharing_checker.dart';

class FakeChecker extends PremiumSharingChecker {
  @override
  bool canUseCloudSharing() => true;
}

class FakeDriveService extends CloudDriveService {
  @override
  Future<bool> uploadFile(File file) async => true;
}

void main() {
  test('uploadFile via WebDAV retourne un lien', () async {
    final service = CloudSharingService(
      driveService: FakeDriveService(),
      checker: FakeChecker(),
    );
    final tmp = File('${Directory.systemTemp.path}/file.txt');
    await tmp.writeAsString('hi');
    final url = await service.uploadFile(tmp, useWebDav: true);
    expect(url, isNotNull);
  });
}
