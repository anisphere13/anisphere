import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:anisphere/modules/noyau/services/camera_service.dart';
import '../../test_config.dart';

class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('takePicture returns photo when permission granted', () async {
    final picker = MockImagePicker();
    final file = XFile('test.jpg');
    when(picker.pickImage(source: ImageSource.camera))
        .thenAnswer((_) async => file);

    final service = CameraService(picker: picker);
    final result = await service.takePicture();

    expect(result, file);
    verify(picker.pickImage(source: ImageSource.camera)).called(2);
  });

  test('takePicture returns null when permission denied', () async {
    final picker = MockImagePicker();
    when(picker.pickImage(source: ImageSource.camera))
        .thenThrow(Exception('denied'));

    final service = CameraService(picker: picker);
    final result = await service.takePicture();

    expect(result, isNull);
    verify(picker.pickImage(source: ImageSource.camera)).called(1);
  });
}
