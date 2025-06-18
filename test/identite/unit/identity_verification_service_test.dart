import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/identite/services/identity_verification_service.dart';
import 'package:anisphere/modules/identite/logic/ia_local_analyzer.dart';
import 'package:mockito/mockito.dart';
import 'mock_services.mocks.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('Ajoute badge IA si photo nette + données valides', () async {
    final identity = IdentityModel(
      animalId: 'a1',
      photoUrl: 'test.jpg',
      microchipNumber: '123456789012345',
      status: 'actif',
    );

    final mockIdentityService = MockIdentityService();
    final mockAnalyzer = MockIdentityLocalAnalyzer();
    when(mockAnalyzer.analyze(any))
        .thenAnswer((_) async => {'photoScore': 0.8});
    final service = IdentityVerificationService(
      identityService: mockIdentityService,
      analyzer: mockAnalyzer,
    );

    await service.verifyIdentityAutomatically(identity: identity, animalName: 'Luna');

    final captured =
    
    // ignore: invalid_use_of_null_value
        verify(mockIdentityService.saveIdentityLocally(captureAny<IdentityModel>()))
            .captured
            .single as IdentityModel;
    expect(captured.verifiedByIA, isTrue);
  });
}
