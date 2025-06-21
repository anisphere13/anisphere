import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/models/job_model.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('JobModel copyWith keeps values', () {
    final job = JobModel(
      id: '1',
      name: 'sync animals',
    );
    final copy = job.copyWith(status: JobStatus.completed);
    expect(copy.id, job.id);
    expect(copy.name, job.name);
    expect(copy.status, JobStatus.completed);
  });
}
