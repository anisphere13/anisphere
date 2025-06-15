import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/services/offline_photo_queue.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('PhotoTaskAdapter has correct typeId', () {
    expect(PhotoTaskAdapter().typeId, 132);
  });
}
