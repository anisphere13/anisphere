import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/models/genealogy_model.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('GenealogyModel toMap/fromMap round trip', () {
    final model = GenealogyModel(
      animalId: 'ani1',
      fatherId: 'dad1',
      motherId: 'mom1',
      siblingsIds: ['sib1', 'sib2'],
    );
    final map = model.toMap();
    final from = GenealogyModel.fromMap(map);
    expect(from.animalId, equals('ani1'));
    expect(from.fatherId, equals('dad1'));
    expect(from.motherId, equals('mom1'));
    expect(from.siblingsIds, equals(['sib1', 'sib2']));
  });
}
