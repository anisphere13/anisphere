// 📁 test/noyau/unit/ia_executor_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'test_config.dart';

// Crée ici les mocks de tes services : IAMaster, NotificationService, etc.

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('IAExecutor exécute une action connue sans erreur', () async {
    // Tu peux ajouter ici un test basique avec un mock de NotificationService
    // Exemple : test de `notify_identity_update_needed`
  });
}
