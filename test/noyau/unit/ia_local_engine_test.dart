import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/ia_recommendation/ia_local_engine.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('Local engine returns a result even without model', () async {
    final engine = IaLocalEngine();
    final animal = AnimalModel(
      id: 'a1',
      name: 'Rex',
      species: 'dog',
      breed: 'labrador',
      imageUrl: '',
      ownerId: 'u1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final res = await engine.recommend(animal: animal);
    expect(res.method.isNotEmpty, isTrue);
  });
}
