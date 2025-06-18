import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/ia_local/ia_model_loader.dart';

import '../../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('loadModel copies asset when missing', () async {
    final dir = await Directory.systemTemp.createTemp('ia_test');
    final file = await IaModelLoader.loadModel(
      'models/behavior.tflite',
      docsDir: dir,
    );
    expect(await file.exists(), isTrue);
    expect(file.path.startsWith(dir.path), isTrue);
  });
}
