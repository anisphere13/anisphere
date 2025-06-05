import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/identite/services/identity_verification_service.dart';
import 'package:anisphere/modules/identite/services/identity_service.dart';
import 'package:anisphere/modules/identite/services/photo_verification_service.dart';
import 'package:mockito/mockito.dart';

class MockIdentityService extends Mock implements IdentityService {}
class MockPhotoVerificationService extends Mock implements PhotoVerificationService {}

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

    when(mockPhotoVerifier.scorePhoto(any<File>()))
        .thenAnswer((_) async => 0.8);
    final service = IdentityVerificationService(
      identityService: mockIdentityService,
      photoVerificationService: mockPhotoVerifier,
    );

    await service.verifyIdentityAutomatically(identity: identity, animalName: 'Luna');

    final captured =
        verify(mockIdentityService.saveIdentityLocally(captureAny)).captured.single
            as IdentityModel;
    expect(captured.verifiedByIA, isTrue);
  });
}
