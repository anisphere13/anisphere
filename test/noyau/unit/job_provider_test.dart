import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/providers/job_provider.dart';
import 'package:anisphere/modules/noyau/models/job_model.dart';
import 'package:anisphere/modules/noyau/services/job_scheduler_service.dart';

class FakeJobSchedulerService extends JobSchedulerService {
  int loadCalls = 0;
  List<JobModel> jobs;
  FakeJobSchedulerService(this.jobs);

  @override
  Future<List<JobModel>> getJobs() async {
    loadCalls++;
    return jobs;
  }
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('loadJobs fetches jobs and notifies listeners', () async {
    final fakeService = FakeJobSchedulerService([
      JobModel(id: '1', name: 'test'),
    ]);
    final provider = JobProvider(service: fakeService);
    var notified = false;
    provider.addListener(() => notified = true);

    await provider.loadJobs();

    expect(fakeService.loadCalls, 1);
    expect(provider.jobs.length, 1);
    expect(notified, isTrue);
  });

  test('updateJob adds and updates jobs with notification', () {
    final provider = JobProvider(service: FakeJobSchedulerService([]));
    var count = 0;
    provider.addListener(() => count++);

    final job = JobModel(id: '1', name: 'a');
    provider.updateJob(job);

    expect(provider.jobs.first.id, '1');
    expect(count, 1);

    provider.updateJob(job.copyWith(status: JobStatus.running));
    expect(provider.jobs.first.status, JobStatus.running);
    expect(count, 2);
  });
}
