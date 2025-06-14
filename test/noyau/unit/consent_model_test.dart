import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/models/consent_model.dart';

import '../../test_config.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive
      ..init(tempDir.path)
      ..registerAdapter(ConsentModelAdapter());
  });

  tearDownAll(() async {
    await Hive.deleteBoxFromDisk('consents');
    await tempDir.delete(recursive: true);
  });

  test('toJson/fromJson round trip', () {
    final model = ConsentModel(
      id: 'c1',
      type: 'export_cloud',
      module: 'export',
      acceptedAt: DateTime.parse('2024-01-01T00:00:00Z'),
      cguVersion: 1,
      scope: const ['photos', 'gps'],
    );
    final json = model.toJson();
    final copy = ConsentModel.fromJson(json);

    expect(copy.id, model.id);
    expect(copy.type, model.type);
    expect(copy.module, model.module);
    expect(copy.acceptedAt.toIso8601String(),
        model.acceptedAt.toIso8601String());
    expect(copy.cguVersion, model.cguVersion);
    expect(copy.scope, model.scope);
    expect(copy.revokedAt, isNull);
  });

  test('Hive adapter stores and retrieves object', () async {
    final box = await Hive.openBox<ConsentModel>('consents');
    final model = ConsentModel(
      id: 'c2',
      type: 'export_cloud',
      module: 'export',
      acceptedAt: DateTime.now(),
      cguVersion: 2,
      scope: const ['metrics'],
    );
    await box.put('c2', model);

    final read = box.get('c2');

    expect(read, isNotNull);
    expect(read!.id, model.id);
    expect(read.type, model.type);
    expect(read.cguVersion, model.cguVersion);
    await box.close();
  });
}
