library;

import '../services/job_scheduler_service.dart';

/// Helper hooks for scheduling background jobs.
///
/// Usage example:
/// ```dart
/// final jobId = await scheduleReminder(
///   DateTime.now().add(const Duration(hours: 1)),
///   'Nourrir Médor',
/// );
/// await cancelJobById(jobId);
/// ```
JobSchedulerService jobSchedulerService = JobSchedulerService();

/// Planifie un rappel via [JobSchedulerService].
Future<String> scheduleReminder(DateTime time, String message) {
  return jobSchedulerService.scheduleReminder(time, message);
}

/// Annule un job planifié par identifiant.
Future<void> cancelJobById(String id) {
  return jobSchedulerService.cancelJobById(id);
}
