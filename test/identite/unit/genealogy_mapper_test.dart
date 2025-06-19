import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/services/genealogy_mapper.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('GenealogyMapper converts between map and model', () {
    final mapper = GenealogyMapper();
    final map = {
      'animalId': 'ani2',
      'fatherName': 'dad2',
      'motherName': 'mom2',
      'affixe': 'Aff2',
      'litterNumber': 'L2',
      'lofName': 'LOF2',
      'lastUpdate': DateTime(2024, 1, 2).toIso8601String(),
    };
    final model = mapper.fromMap(map);
    expect(model.fatherName, 'dad2');
    expect(model.affixe, 'Aff2');
    final back = mapper.toMap(model);
    expect(back, map);
  });
}
