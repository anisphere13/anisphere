
import 'package:flutter/foundation.dart';

import '../models/job_model.dart';
import '../services/job_scheduler_service.dart';

/// Provider exposing scheduled jobs and their status.
class JobProvider with ChangeNotifier {
  final JobSchedulerService _service;
  List<JobModel> _jobs = [];

  JobProvider({JobSchedulerService? service})
      : _service = service ?? JobSchedulerService();

  /// Public unmodifiable view of jobs.
  List<JobModel> get jobs => List.unmodifiable(_jobs);

  /// Jobs waiting to start.
  List<JobModel> get pendingJobs =>
      _jobs.where((j) => j.status == JobStatus.pending).toList();

  /// Currently running jobs.
  List<JobModel> get runningJobs =>
      _jobs.where((j) => j.status == JobStatus.running).toList();

  /// Successfully completed jobs.
  List<JobModel> get completedJobs =>
      _jobs.where((j) => j.status == JobStatus.completed).toList();

  /// Jobs that ended in error.
  List<JobModel> get failedJobs =>
      _jobs.where((j) => j.status == JobStatus.failed).toList();

  /// Load jobs from the [JobSchedulerService].
  Future<void> loadJobs() async {
    _jobs = await _service.getJobs();
    notifyListeners();
  }

  /// Update or insert a job, notifying listeners of changes.
  void updateJob(JobModel job) {
    final index = _jobs.indexWhere((j) => j.id == job.id);
    if (index >= 0) {
      _jobs[index] = job;
    } else {
      _jobs.add(job);
    }
    notifyListeners();
  }
}
