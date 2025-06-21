import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('IdentityModel should serialize and deserialize correctly', () {
    final identity = IdentityModel(
      animalId: 'abc123',
      aiScore: 0.8,
      verifiedBreed: true,
      photoTimeline: const ['a', 'b'],
      litterNumber: 'L1',
      lofNumber: 'LOF123',
      originCountry: 'FR',
      alias: 'Loulou',
      breederName: 'Bob',
      breederAddress: '1 rue',
      breederSiret: '123',
      breederEmail: 'bob@example.com',
      breederWebsite: 'https://bob.com',
      breederPhone: '0600',
    );
    final map = identity.toMap();
    final deserialized = IdentityModel.fromMap(map);

    expect(deserialized.animalId, equals('abc123'));
    expect(deserialized.verifiedByIA, isFalse);
    expect(deserialized.aiScore, equals(0.0));
    expect(deserialized.verifiedBreed, isFalse);
  });
}
