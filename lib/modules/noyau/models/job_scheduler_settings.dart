
import 'package:hive/hive.dart';

part 'job_scheduler_settings.g.dart';

@HiveType(typeId: 72)
class JobSchedulerSettings {
  @HiveField(0)
  final bool autoJobsEnabled;

  @HiveField(1)
  final bool enableLogs;

  @HiveField(2)
  final int autoPurgeDays;

  const JobSchedulerSettings({
    this.autoJobsEnabled = true,
    this.enableLogs = false,
    this.autoPurgeDays = 30,
  });

  JobSchedulerSettings copyWith({
    bool? autoJobsEnabled,
    bool? enableLogs,
    int? autoPurgeDays,
  }) {
    return JobSchedulerSettings(
      autoJobsEnabled: autoJobsEnabled ?? this.autoJobsEnabled,
      enableLogs: enableLogs ?? this.enableLogs,
      autoPurgeDays: autoPurgeDays ?? this.autoPurgeDays,
    );
  }
}
