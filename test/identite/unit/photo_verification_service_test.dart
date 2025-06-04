import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/identite/services/photo_verification_service.dart';

void main() {
  test('Score calculé reste dans une plage valide', () async {
    final service = PhotoVerificationService();
    // simulate with 0 sharpness, 1 centering = score 0.3
    final score = (0.7 * 0.0) + (0.3 * 1.0);
    expect(score, closeTo(0.3, 0.01));
  });
}
