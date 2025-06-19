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
      fatherName: 'dad1',
      motherName: 'mom1',
      affixe: 'Affix',
      litterNumber: 'L1',
      lofName: 'LOF123',
      lastUpdate: DateTime(2024, 1, 1),
    );
    final map = model.toMap();
    final from = GenealogyModel.fromMap(map);
    expect(from.animalId, equals('ani1'));
    expect(from.fatherName, equals('dad1'));
    expect(from.motherName, equals('mom1'));
    expect(from.affixe, equals('Affix'));
    expect(from.litterNumber, equals('L1'));
    expect(from.lofName, equals('LOF123'));
  });
}
