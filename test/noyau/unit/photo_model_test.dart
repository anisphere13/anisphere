import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/models/photo_model.dart';

void main() {
  test('PhotoModel toJson/fromJson round trip', () {
    final model = PhotoModel(
      id: '1',
      userId: 'u1',
      animalId: 'a1',
      localPath: '/tmp/img.png',
      createdAt: DateTime.parse('2024-01-01'),
      uploaded: false,
      remoteUrl: null,
    );
    final json = model.toJson();
    final copy = PhotoModel.fromJson(json);
    expect(copy.id, model.id);
    expect(copy.localPath, model.localPath);
    expect(copy.uploaded, model.uploaded);
  });
}
