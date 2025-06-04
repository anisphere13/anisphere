import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/services/qr_generator_service.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('QR public URL should be generated correctly', () async {
    final service = QRGeneratorService();
    final url = await service.publishPublicIdentity(
      animalId: 'abc123',
      publicData: {'name': 'Max'},
    );
    expect(url, contains('abc123'));
  });
}
