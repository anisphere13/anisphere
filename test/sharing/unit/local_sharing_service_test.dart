import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/sharing/services/local_sharing_service.dart';

void main() {
  group('LocalSharingService', () {
    test('share adds id to local set', () {
      final service = LocalSharingService();
      service.share('a1');

      expect(service.isShared('a1'), isTrue);
    });
  });
}
