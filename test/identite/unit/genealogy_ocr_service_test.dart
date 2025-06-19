import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/services/genealogy_ocr_service.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('parseText extracts father and mother ids', () {
    final service = GenealogyOCRService();
    const sample = 'Father ID: F123\nSome text\nMother ID: M456';
    final result = service.parseText(sample);
    expect(result['fatherId'], 'F123');
    expect(result['motherId'], 'M456');
    service.dispose();
  });
}
