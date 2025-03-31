import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/models/user_model.dart';

void main() {
  group('USER_MODEL - Tests unitaires', () {
    test('Création d\'un UserModel valide', () {
      final user = UserModel(
        uid: '123',
        email: 'test@example.com',
        roles: ['propriétaire'],
      );

      expect(user.uid, '123');
      expect(user.email, 'test@example.com');
      expect(user.roles.contains('propriétaire'), isTrue);
    });

    test('Conversion toMap / fromMap cohérente', () {
      final user = UserModel(
        uid: 'abc',
        email: 'user@demo.com',
        roles: ['vétérinaire'],
      );

      final map = user.toMap();
      final fromMap = UserModel.fromMap(map);

      expect(fromMap.uid, user.uid);
      expect(fromMap.email, user.email);
      expect(fromMap.roles, user.roles);
    });
  });
}
