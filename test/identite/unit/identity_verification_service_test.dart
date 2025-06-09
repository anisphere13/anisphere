import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/identite/services/identity_verification_service.dart';
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
    final mockPhotoVerifier = MockPhotoVerificationService();
    // ignore: invalid_use_of_null_value
    when(mockPhotoVerifier.scorePhoto(any<File>(that: isA<File>())))
        .thenAnswer((_) async => 0.8);
    final service = IdentityVerificationService(
      identityService: mockIdentityService,
      photoVerificationService: mockPhotoVerifier,
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
