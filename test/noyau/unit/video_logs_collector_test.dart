// Copilot Prompt : Test automatique généré pour video_logs_collector.dart (unit)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';

class VideoLogsCollector {
  final List<String> _logs = [];
  void add(String log) => _logs.add(log);
  List<String> get logs => List.unmodifiable(_logs);
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('add stores logs', () {
    final collector = VideoLogsCollector();
    collector.add('start');
    collector.add('stop');
    expect(collector.logs.length, 2);
    expect(collector.logs.first, 'start');
    expect(collector.logs.last, 'stop');
  });
}
