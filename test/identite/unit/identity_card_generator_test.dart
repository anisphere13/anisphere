import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/identite/services/identity_card_generator.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';

void main() {
  test('PDF mini-carte est généré sans erreur', () async {
    final generator = IdentityCardGenerator();
    final identity = IdentityModel(animalId: 'abc123');
    final pdf = await generator.generateCard(
      identity: identity,
      animalName: 'Luna',
      qrUrl: 'https://anisphere.app/animal/abc123',
    );
    expect(pdf.lengthInBytes, greaterThan(100));
  });
}
