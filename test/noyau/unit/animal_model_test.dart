// Copilot Prompt : Test automatique généré pour animal_model.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('toJson and fromJson preserve fields', () {
    final now = DateTime.now();
    final animal = AnimalModel(
      id: 'a1',
      name: 'Rex',
      species: 'dog',
      breed: 'Labrador',
      imageUrl: 'url',
      ownerId: 'u1',
      createdAt: now,
      updatedAt: now,
    );

    final json = animal.toJson();
    final copy = AnimalModel.fromJson(json);

    expect(copy.id, animal.id);
    expect(copy.name, animal.name);
  });
}
