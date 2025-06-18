
import 'package:flutter/foundation.dart';
import '../models/job_model.dart';

/// Simple service de planification de tâches.
/// Permet d'enregistrer des rappels locaux et de les annuler.
class JobSchedulerService {
  final Map<String, _Job> _jobs = {};

  /// Planifie un rappel à [time] avec [message].
  /// Retourne un identifiant unique du job.
  Future<String> scheduleReminder(DateTime time, String message) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    _jobs[id] = _Job(time, message);
    debugPrint('🗓️ Job $id programmé pour $time');
    return id;
  }

  /// Annule le job identifié par [id].
  Future<void> cancelJobById(String id) async {
    _jobs.remove(id);
    debugPrint('❌ Job $id annulé');
  }

  /// Vérifie si un job existe.
  bool hasJob(String id) => _jobs.containsKey(id);

  /// Retourne la liste des jobs planifiés.
  Future<List<JobModel>> getJobs() async {
    return _jobs.entries
        .map((e) => JobModel(
              id: e.key,
              name: e.value.message,
              createdAt: e.value.time,
            ))
        .toList();
  }
}

class _Job {
  final DateTime time;
  final String message;
  _Job(this.time, this.message);
}
