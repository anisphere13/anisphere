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
      'fatherId': 'dad2',
      'motherId': 'mom2',
      'siblingsIds': ['s1']
    };
    final model = mapper.fromMap(map);
    expect(model.fatherId, 'dad2');
    final back = mapper.toMap(model);
    expect(back, map);
  });
}
