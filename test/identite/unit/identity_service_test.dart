import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/identite/services/identity_service.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

class MockBox extends Mock implements Box<IdentityModel> {}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('saveIdentityLocally should store model by animalId', () async {
    final mockBox = MockBox();
    final service = IdentityService(localBox: mockBox);

    final identity = IdentityModel(animalId: 'abc123');

    await service.saveIdentityLocally(identity);

    verify(mockBox.put('abc123', identity)).called(1);
  });

  test('computeCompletionScore stores aiScore in model', () async {
    final mockBox = MockBox();
    final service = IdentityService(localBox: mockBox);
    final model = IdentityModel(
      animalId: 'a1',
      microchipNumber: '1',
      photoUrl: 'p',
      status: 'ok',
      legalStatus: 'dog',
    );
    when(mockBox.put(any, any)).thenAnswer((_) async {});

    final score = await service.computeCompletionScore(model);

    final saved =
        verify(mockBox.put('a1', captureAny)).captured.single as IdentityModel;
    expect(saved.aiScore, closeTo(1.0, 0.01));
    expect(score, closeTo(1.0, 0.01));
  });

  test('detectSiblingDuplicates sets verifiedBreed when duplicate found',
      () async {
    final mockBox = MockBox();
    final existing = IdentityModel(
      animalId: 'old',
      microchipNumber: 'dup',
    );
    when(mockBox.values).thenReturn([existing]);
    final service = IdentityService(localBox: mockBox);
    final model = IdentityModel(animalId: 'new', microchipNumber: 'dup');
    when(mockBox.put(any, any)).thenAnswer((_) async {});

    final result = await service.detectSiblingDuplicates(model);

    final saved =
        verify(mockBox.put('new', captureAny)).captured.single as IdentityModel;
    expect(saved.verifiedBreed, isTrue);
    expect(result, isTrue);
  });
}
