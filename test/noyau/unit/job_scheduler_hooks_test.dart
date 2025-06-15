import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/hooks/job_scheduler_hooks.dart';
import 'package:anisphere/modules/noyau/services/job_scheduler_service.dart';

class FakeJobSchedulerService extends Fake implements JobSchedulerService {
  bool scheduled = false;
  bool canceled = false;

  @override
  Future<String> scheduleReminder(DateTime time, String message) async {
    scheduled = true;
    return 'job1';
  }

  @override
  Future<void> cancelJobById(String id) async {
    canceled = true;
  }
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('scheduleReminder forwards to service', () async {
    final service = FakeJobSchedulerService();
    jobSchedulerService = service;
    await scheduleReminder(DateTime.now(), 'test');
    expect(service.scheduled, isTrue);
  });

  test('cancelJobById forwards to service', () async {
    final service = FakeJobSchedulerService();
    jobSchedulerService = service;
    await cancelJobById('job1');
    expect(service.canceled, isTrue);
  });
}
