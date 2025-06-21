// Copilot Prompt : Test automatique généré pour video_model.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';

class VideoModel {
  final String id;
  final String url;
  final Duration duration;
  VideoModel({required this.id, required this.url, required this.duration});

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'duration': duration.inSeconds,
      };

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      duration: Duration(seconds: json['duration'] ?? 0),
    );
  }
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('toJson/fromJson preserve fields', () {
    final model = VideoModel(id: 'v1', url: 'path', duration: Duration(seconds: 5));
    final json = model.toJson();
    final copy = VideoModel.fromJson(json);
    expect(copy.id, model.id);
    expect(copy.url, model.url);
    expect(copy.duration, model.duration);
  });
}
