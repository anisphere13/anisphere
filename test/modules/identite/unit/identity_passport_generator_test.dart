import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/identite/services/identity_passport_generator.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';

void main() {
  test('Passeport PDF premium généré correctement', () async {
    final generator = IdentityPassportGenerator();
    final identity = IdentityModel(animalId: 'abc123', microchipNumber: '123456789');
    final pdf = await generator.generatePremiumPassport(
      identity: identity,
      animalName: 'Rex',
      photo: null,
      qrUrl: 'https://anisphere.app/animal/abc123',
    );
    expect(pdf.lengthInBytes, greaterThan(300));
  });
}
