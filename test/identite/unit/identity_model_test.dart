import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';

void main() {
  test('IdentityModel should serialize and deserialize correctly', () {
    final identity = IdentityModel(animalId: 'abc123');
    final map = identity.toMap();
    final deserialized = IdentityModel.fromMap(map);

    expect(deserialized.animalId, equals('abc123'));
    expect(deserialized.verifiedByIA, isFalse);
  });
}
