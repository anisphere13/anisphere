import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/identite/services/qr_generator_service.dart';

void main() {
  test('QR public URL should be generated correctly', () async {
    final service = QRGeneratorService();
    final url = await service.publishPublicIdentity(
      animalId: 'abc123',
      publicData: {'name': 'Max'},
    );
    expect(url, contains('abc123'));
  });
}
