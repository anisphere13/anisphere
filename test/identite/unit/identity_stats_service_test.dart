import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/services/identity_stats_service.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/identite/models/genealogy_model.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('compute returns completeness and months since update', () {
    final now = DateTime.now();
    final identity = IdentityModel(
      animalId: 'a',
      microchipNumber: '123',
      status: 'ok',
      lastUpdate: now.subtract(const Duration(days: 60)),
    );
    final genealogy = GenealogyModel(animalId: 'a', fatherName: 'F', motherName: 'M');
    final service = IdentityStatsService();

    final stats = service.compute(identity: identity, genealogy: genealogy);

    expect(stats.monthsSinceUpdate, 2);
    expect(stats.completeness, closeTo(50.0, 0.1));
  });
}
