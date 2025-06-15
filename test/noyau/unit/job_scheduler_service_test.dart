import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/job_scheduler_service.dart';
import 'package:anisphere/modules/noyau/models/job_model.dart';
import '../../test_config.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(JobModelAdapter());
    await JobSchedulerService.init();
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('scheduled_jobs');
    await tempDir.delete(recursive: true);
  });

  test('addJob stores job in box', () async {
    final job = JobSchedulerService.createJob(
      type: 'sync',
      target: 'animals',
      nextRun: DateTime.now(),
    );
    await JobSchedulerService.addJob(job);
    final box = await Hive.openBox<JobModel>('scheduled_jobs');
    expect(box.get(job.id)?.type, 'sync');
  });

  test('executeDueJobs runs and clears', () async {
    final job = JobSchedulerService.createJob(
      type: 'sync',
      target: 'animals',
      nextRun: DateTime.now().subtract(const Duration(seconds: 1)),
    );
    await JobSchedulerService.addJob(job);
    int count = 0;
    await JobSchedulerService.executeDueJobs((j) async {
      count++;
    });
    expect(count, 1);
    final box = await Hive.openBox<JobModel>('scheduled_jobs');
    expect(box.isEmpty, true);
  });
}
