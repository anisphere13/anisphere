import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/models/module_model.dart';

void main() {
  group('ModuleModel serialization', () {
    final module = ModuleModel(
      id: 'sante',
      name: 'Santé',
      category: 'Bien-être',
      description: 'Suivi santé',
      icon: '🩺',
      premium: true,
    );

    test('toMap returns expected map', () {
      expect(module.toMap(), {
        'id': 'sante',
        'name': 'Santé',
        'category': 'Bien-être',
        'description': 'Suivi santé',
        'icon': '🩺',
        'premium': true,
      });
    });

    test('fromMap restores ModuleModel', () {
      final restored = ModuleModel.fromMap(module.toMap());
      expect(restored.id, module.id);
      expect(restored.name, module.name);
      expect(restored.category, module.category);
      expect(restored.description, module.description);
      expect(restored.icon, module.icon);
      expect(restored.premium, module.premium);
    });
  });
}
