// Copilot Prompt : Test automatique généré pour video_analysis_config.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';

class VideoAnalysisConfig {
  final int frameRate;
  final int resolution;
  const VideoAnalysisConfig({this.frameRate = 30, this.resolution = 720});

  Map<String, dynamic> toJson() => {
        'frameRate': frameRate,
        'resolution': resolution,
      };

  factory VideoAnalysisConfig.fromJson(Map<String, dynamic> json) {
    return VideoAnalysisConfig(
      frameRate: json['frameRate'] ?? 30,
      resolution: json['resolution'] ?? 720,
    );
  }
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('fromJson uses defaults', () {
    final config = VideoAnalysisConfig.fromJson({});
    expect(config.frameRate, 30);
    expect(config.resolution, 720);
  });

  test('toJson returns expected map', () {
    const cfg = VideoAnalysisConfig(frameRate: 60, resolution: 1080);
    expect(cfg.toJson(), {'frameRate': 60, 'resolution': 1080});
  });
}
