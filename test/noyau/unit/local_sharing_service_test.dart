import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/services/local_sharing_service.dart';

void main() {
  test('shareViaQR crée un widget', () {
    final service = LocalSharingService();
    final widget = service.shareViaQR('demo');
    expect(widget, isNotNull);
  });
}
