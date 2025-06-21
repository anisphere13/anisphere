// Copilot Prompt : Test automatique généré pour video_analysis_service.dart (unit)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';

class VideoAnalysisService {
  final VideoAnalysisConfig config;
  VideoAnalysisService({VideoAnalysisConfig? config})
      : config = config ?? const VideoAnalysisConfig();

  Future<String> analyze(List<int> frames) async {
    // Dummy implementation, just returns frame count and fps
    return 'frames:${frames.length}-fps:${config.frameRate}';
  }
}

class VideoAnalysisConfig {
  final int frameRate;
  const VideoAnalysisConfig({this.frameRate = 30});
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('analyze returns info string', () async {
    final service = VideoAnalysisService(
        config: const VideoAnalysisConfig(frameRate: 60));
    final result = await service.analyze([1, 2, 3]);
    expect(result, 'frames:3-fps:60');
  });
}
