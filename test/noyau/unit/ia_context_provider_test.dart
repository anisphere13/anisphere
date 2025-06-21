// Copilot Prompt : Test automatique généré pour ia_context_provider.dart (unit)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/providers/ia_context_provider.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('update modifies context values', () {
    final provider = IAContextProvider();
    provider.update(isOffline: true, animalCount: 3);
    expect(provider.context.isOffline, isTrue);
    expect(provider.context.animalCount, 3);
  });
}
