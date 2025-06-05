import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/identite/services/legal_status_service.dart';
import 'package:anisphere/modules/identite/services/identity_service.dart';
import 'package:mockito/mockito.dart';

class MockIdentityService extends Mock implements IdentityService {}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('updateLegalStatus modifie correctement le statut juridique', () async {
    final mockService = MockIdentityService();
    final model = IdentityModel(animalId: 'test');
    when(mockService.getIdentityLocally('test')).thenReturn(model);

    final legalStatusService = LegalStatusService(identityService: mockService);
    await legalStatusService.updateLegalStatus(animalId: 'test', newStatus: 'chien d’assistance');

    verify(mockService.saveIdentityLocally(any<IdentityModel>())).called(1);
  });
}
