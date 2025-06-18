import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:anisphere/modules/noyau/services/ia_interpreter_loader.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../test_config.dart';

class MockInterpreter extends Mock implements Interpreter {}

Future<Interpreter> _mockCreator(String _) async => MockInterpreter();
Future<Interpreter> _throwingCreator(String _) => Future.error(Exception('missing'));

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('load returns true with valid interpreter', () async {
    final loader = IaInterpreterLoader(modelPath: 'models/dummy.tflite', creator: _mockCreator);

    final result = await loader.load();

    expect(result, isTrue);
    expect(loader.interpreter, isA<Interpreter>());
  });

  test('load returns false when model missing', () async {
    final loader = IaInterpreterLoader(modelPath: 'missing.tflite', creator: _throwingCreator);

    final result = await loader.load();

    expect(result, isFalse);
    expect(loader.interpreter, isNull);
  });

  test('predict uses interpreter', () async {
    final mock = MockInterpreter();
    when(() => mock.run(any<Object?>(), any<Object?>())).thenAnswer((invocation) {
      final output = invocation.positionalArguments[1] as List;
      (output.first as List)[0] = 3.14;
    });
    final loader = IaInterpreterLoader(modelPath: 'models/dummy.tflite', creator: (_) async => mock);
    await loader.load();

    final result = await loader.predict([1.0]);

    expect(result, [3.14]);
    verify(() => mock.run(any<Object?>(), any<Object?>())).called(1);
  });
}
