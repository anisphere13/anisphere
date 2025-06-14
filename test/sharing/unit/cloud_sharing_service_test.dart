import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/sharing/services/cloud_sharing_service.dart';

void main() {
  group('CloudSharingService', () {
    test('upload stores data and returns true', () async {
      final service = CloudSharingService();
      final result = await service.upload('demo');

      expect(result, isTrue);
      expect(service.uploaded.contains('demo'), isTrue);
    });
  });
}
