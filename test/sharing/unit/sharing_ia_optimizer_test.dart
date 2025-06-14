import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/sharing/services/sharing_ia_optimizer.dart';

void main() {
  group('SharingIAOptimizer', () {
    test('optimize trims and lowercases', () {
      final result = SharingIAOptimizer.optimize('  Hello ');
      expect(result, 'hello');
    });
  });
}
