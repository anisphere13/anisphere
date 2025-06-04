import 'package:flutter_test/flutter_test.dart';

void main() {
  test('RegExp extracts microchip number', () {
    const sample = 'Numéro de puce : 250269604785123';
    final match = RegExp(r'(\d{15})').firstMatch(sample);
    expect(match?.group(1), equals('250269604785123'));
  });
}
