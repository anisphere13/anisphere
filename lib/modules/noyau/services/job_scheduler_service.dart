library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../models/job_model.dart';

class JobSchedulerService {
  static const String _boxName = 'scheduled_jobs';
  static Box<JobModel>? _box;

  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(130)) {
      Hive.registerAdapter(JobModelAdapter());
    }
    _box = await Hive.openBox<JobModel>(_boxName);
  }

  static Future<void> addJob(JobModel job) async {
    await _ensureBox();
    await _box!.put(job.id, job);
    debugPrint('📅 Job ajouté : ${job.type} -> ${job.target}');
  }

  static Future<void> cancelJob(String id) async {
    await _ensureBox();
    await _box!.delete(id);
    debugPrint('🗑️ Job annulé : $id');
  }

  static Future<void> rescheduleJob(String id, DateTime nextRun) async {
    await _ensureBox();
    final job = _box!.get(id);
    if (job != null) {
      await _box!.put(
        id,
        job.copyWith(nextRun: nextRun, updatedAt: DateTime.now()),
      );
      debugPrint('🔁 Job replanifié : $id -> $nextRun');
    }
  }

  static Future<void> executeDueJobs(
    Future<void> Function(JobModel job) handler,
  ) async {
    await _ensureBox();
    final now = DateTime.now();
    final jobs = _box!.values.where((j) => j.nextRun.isBefore(now));
    for (final job in jobs) {
      try {
        await handler(job);
        await _box!.delete(job.id);
      } catch (e) {
        final updatedLogs = List<String>.from(job.logs)..add(e.toString());
        final updated = job.copyWith(
          attempt: job.attempt + 1,
          logs: updatedLogs,
          updatedAt: DateTime.now(),
        );
        await _box!.put(job.id, updated);
        debugPrint('❌ Job ${job.id} échec : $e');
      }
    }
  }

  static Future<void> replayPendingJobs(
    Future<void> Function(JobModel job) handler,
  ) async {
    await executeDueJobs(handler);
  }

  static Future<void> _ensureBox() async {
    if (_box == null || !_box!.isOpen) {
      await init();
    }
  }

  /// Utilitaire pour créer rapidement un job avec id unique.
  static JobModel createJob({
    required String type,
    required String target,
    required DateTime nextRun,
  }) {
    return JobModel(
      id: const Uuid().v4(),
      type: type,
      target: target,
      nextRun: nextRun,
    );
  }
}
