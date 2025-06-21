import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:mockito/mockito.dart';
import 'package:anisphere/modules/identite/services/identity_photo_selection_service.dart';
import 'package:anisphere/modules/identite/services/photo_verification_service.dart';

class MockPhotoVerificationService extends Mock implements PhotoVerificationService {}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('selectBest returns file with highest score', () async {
    final mock = MockPhotoVerificationService();
    final service = IdentityPhotoSelectionService(verifier: mock);
    final f1 = await File('${Directory.systemTemp.path}/f1.jpg').create();
    final f2 = await File('${Directory.systemTemp.path}/f2.jpg').create();

    when(mock.scorePhoto(f1)).thenAnswer((_) async => 0.2);
    when(mock.scorePhoto(f2)).thenAnswer((_) async => 0.9);

    final best = await service.selectBest([f1, f2]);
    expect(best, f2);

    await f1.delete();
    await f2.delete();
  });
}
