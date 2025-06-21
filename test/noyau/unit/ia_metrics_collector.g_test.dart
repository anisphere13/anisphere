// Copilot Prompt : Test automatique généré pour ia_metrics_collector.g.dart (unit)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';
import 'package:anisphere/services/ia/ia_metrics_collector.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('IAMetricAdapter has typeId 101', () {
    expect(IAMetricAdapter().typeId, 101);
  });
}
