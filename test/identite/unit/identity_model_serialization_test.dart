import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('IdentityModel serializes all new fields', () {
    final model = IdentityModel(
      animalId: 'id1',
      aiScore: 0.5,
      verifiedBreed: true,
      photoTimeline: const ['u1'],
      litterNumber: 'N123',
      lofNumber: 'LOF1',
      originCountry: 'FR',
      alias: 'Buddy',
      breederName: 'John',
      breederAddress: 'Street 1',
      breederSiret: 'S1',
      breederEmail: 'john@ex.com',
      breederWebsite: 'https://john.com',
      breederPhone: '0000',
    );

    final map = model.toMap();
    final from = IdentityModel.fromMap(map);

    expect(from.aiScore, 0.5);
    expect(from.verifiedBreed, isTrue);
    expect(from.photoTimeline, ['u1']);
    expect(from.litterNumber, 'N123');
    expect(from.lofNumber, 'LOF1');
    expect(from.originCountry, 'FR');
    expect(from.alias, 'Buddy');
    expect(from.breederName, 'John');
    expect(from.breederAddress, 'Street 1');
    expect(from.breederSiret, 'S1');
    expect(from.breederEmail, 'john@ex.com');
    expect(from.breederWebsite, 'https://john.com');
    expect(from.breederPhone, '0000');
  });
}
