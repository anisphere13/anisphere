import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/models/job_scheduler_settings.dart';
import 'package:anisphere/modules/noyau/services/job_scheduler_settings_service.dart';
import '../../test_config.dart';

void main() {
  late Directory tempDir;
  late JobSchedulerSettingsService service;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive
      ..init(tempDir.path)
      ..registerAdapter(JobSchedulerSettingsAdapter());
    service = JobSchedulerSettingsService();
    await Hive.openBox<JobSchedulerSettings>(JobSchedulerSettingsService.boxName);
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk(JobSchedulerSettingsService.boxName);
    await tempDir.delete(recursive: true);
  });

  test('save and retrieve settings', () async {
    final settings = JobSchedulerSettings(
      autoJobsEnabled: false,
      enableLogs: true,
      autoPurgeDays: 7,
    );
    await service.saveSettings(settings);
    final loaded = await service.getSettings();
    expect(loaded.autoJobsEnabled, false);
    expect(loaded.enableLogs, true);
    expect(loaded.autoPurgeDays, 7);
  });

  test('update methods modify stored values', () async {
    await service.saveSettings(const JobSchedulerSettings());
    await service.updateAutoJobsEnabled(false);
    await service.updateEnableLogs(true);
    await service.updateAutoPurgeDays(10);
    final loaded = await service.getSettings();
    expect(loaded.autoJobsEnabled, false);
    expect(loaded.enableLogs, true);
    expect(loaded.autoPurgeDays, 10);
  });
}
