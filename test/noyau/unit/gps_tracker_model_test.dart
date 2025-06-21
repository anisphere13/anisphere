import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/models/gps_tracker_model.dart';

void main() {
  test('GpsTrackerModel toJson/fromJson round trip', () {
    final model = GpsTrackerModel(
      timestamp: DateTime.parse('2025-01-01T12:00:00Z'),
      latitude: 48.8566,
      longitude: 2.3522,
      context: 'walk',
      iaTags: ['gps', 'tracking'],
    );
    final json = model.toJson();
    final copy = GpsTrackerModel.fromJson(json);

    expect(copy.timestamp.toIso8601String(), model.timestamp.toIso8601String());
    expect(copy.latitude, model.latitude);
    expect(copy.longitude, model.longitude);
    expect(copy.context, model.context);
    expect(copy.iaTags, model.iaTags);
  });
}
