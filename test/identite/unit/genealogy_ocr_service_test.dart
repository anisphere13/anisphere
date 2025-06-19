import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/services/genealogy_ocr_service.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('parseText extracts father and mother names', () {
    final service = GenealogyOCRService();
    const sample = 'Father: F123\nSome text\nMother: M456';
    final result = service.parseText(sample);
    expect(result['fatherName'], 'F123');
    expect(result['motherName'], 'M456');
    service.dispose();
  });
}
