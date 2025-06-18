import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:anisphere/modules/noyau/ia_local/ia_model_updater.dart';

import '../../../test_config.dart';

class MockFirebaseStorage extends Mock implements FirebaseStorage {}
class MockReference extends Mock implements Reference {}

class FakePathProviderPlatform extends Fake implements PathProviderPlatform {
  FakePathProviderPlatform(this.path);
  final String path;
  @override
  Future<String?> getApplicationDocumentsPath() async => path;
}

void main() {
  late Directory tempDir;
  late PathProviderPlatform originalPlatform;

  setUpAll(() async {
    await initTestEnv();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp();
    originalPlatform = PathProviderPlatform.instance;
    PathProviderPlatform.instance = FakePathProviderPlatform(tempDir.path);
  });

  tearDown(() async {
    PathProviderPlatform.instance = originalPlatform;
    await tempDir.delete(recursive: true);
  });

  test('download saves model in documents/models', () async {
    final storage = MockFirebaseStorage();
    final ref = MockReference();
    when(storage.ref('ia_models/model.tflite')).thenReturn(ref);
    when(ref.getData()).thenAnswer((_) async => Uint8List.fromList([1, 2, 3]));

    final updater = IaModelUpdater(storage: storage);
    final file = await updater.download('model.tflite');

    expect(await file.exists(), isTrue);
    expect(file.path, p.join(tempDir.path, 'models', 'model.tflite'));
    expect(await file.readAsBytes(), [1, 2, 3]);
  });
}
