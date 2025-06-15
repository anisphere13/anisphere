import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/services/job_scheduler_service.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('scheduleReminder returns id and stores job', () async {
    final service = JobSchedulerService();
    final id = await service.scheduleReminder(DateTime.now(), 'test');
    expect(service.hasJob(id), isTrue);
  });

  test('cancelJobById removes job', () async {
    final service = JobSchedulerService();
    final id = await service.scheduleReminder(DateTime.now(), 'test');
    await service.cancelJobById(id);
    expect(service.hasJob(id), isFalse);
  });
}
