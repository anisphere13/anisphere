library;

import 'package:hive/hive.dart';

import '../models/job_scheduler_settings.dart';

class JobSchedulerSettingsService {
  static const String boxName = 'job_scheduler_settings';
  Box<JobSchedulerSettings>? _box;

  Future<Box<JobSchedulerSettings>> _openBox() async {
    if (_box != null && _box!.isOpen) return _box!;
    if (!Hive.isAdapterRegistered(72)) {
      Hive.registerAdapter(JobSchedulerSettingsAdapter());
    }
    _box = Hive.isBoxOpen(boxName)
        ? Hive.box<JobSchedulerSettings>(boxName)
        : await Hive.openBox<JobSchedulerSettings>(boxName);
    return _box!;
  }

  Future<JobSchedulerSettings> getSettings() async {
    final box = await _openBox();
    return box.get('settings') ?? const JobSchedulerSettings();
  }

  Future<void> saveSettings(JobSchedulerSettings settings) async {
    final box = await _openBox();
    await box.put('settings', settings);
  }

  Future<void> updateAutoJobsEnabled(bool value) async {
    final current = await getSettings();
    await saveSettings(current.copyWith(autoJobsEnabled: value));
  }

  Future<void> updateEnableLogs(bool value) async {
    final current = await getSettings();
    await saveSettings(current.copyWith(enableLogs: value));
  }

  Future<void> updateAutoPurgeDays(int days) async {
    final current = await getSettings();
    await saveSettings(current.copyWith(autoPurgeDays: days));
  }
}
