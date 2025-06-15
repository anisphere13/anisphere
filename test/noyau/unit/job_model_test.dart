import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/models/job_model.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('JobModel copyWith keeps values', () {
    final job = JobModel(
      id: '1',
      type: 'sync',
      target: 'animals',
      nextRun: DateTime.now(),
    );
    final copy = job.copyWith(status: 'done');
    expect(copy.id, job.id);
    expect(copy.type, job.type);
    expect(copy.status, 'done');
  });
}
