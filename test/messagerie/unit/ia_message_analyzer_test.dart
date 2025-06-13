import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/messagerie/logic/ia_message_analyzer.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  final analyzer = IAMessageAnalyzer();

  test('detect greeting intent', () {
    final result = analyzer.analyze('Bonjour, ça va ?');
    expect(result['intent'], 'greeting');
    expect(result['feedback']!.isNotEmpty, isTrue);
  });

  test('detect thanks intent', () {
    final result = analyzer.analyze('merci pour ton aide');
    expect(result['intent'], 'thanks');
  });

  test('detect complaint intent', () {
    final result = analyzer.analyze('Il y a un bug ici');
    expect(result['intent'], 'complaint');
  });

  test('detect question intent', () {
    final result = analyzer.analyze('Que puis-je faire ?');
    expect(result['intent'], 'question');
  });
}
