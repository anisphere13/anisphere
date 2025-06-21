// Copilot Prompt : VideoLogsCollector sends anonymized results of video analysis to logs_ia/.
// Videos themselves are never persisted in Firebase or any cloud storage.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'anonymization_service.dart';
import 'offline_sync_queue.dart';

/// Collects anonymized video analysis results and uploads them to Firestore.
class VideoLogsCollector {
  final FirebaseFirestore firestore;
  final AnonymizationService _anonymizer;

  VideoLogsCollector({
    FirebaseFirestore? firestoreInstance,
    AnonymizationService? anonymizer,
  })  : firestore = firestoreInstance ?? FirebaseFirestore.instance,
        _anonymizer = anonymizer ?? const AnonymizationService();

  /// Uploads an anonymized result to `logs_ia/`.
  ///
  /// If the upload fails (typically offline), the entry is queued via
  /// [OfflineSyncQueue].
  Future<void> uploadResult(Map<String, dynamic> result) async {
    final sanitized = _anonymizer.anonymizeMap(result, ['userId', 'animalId']);
    final category = sanitized['module'] as String? ?? 'general';
    final data = <String, dynamic>{
      ...sanitized,
      'timestamp': sanitized['timestamp'] ?? DateTime.now().toIso8601String(),
    };

    try {
      await firestore
          .collection('logs_ia')
          .doc(category)
          .collection('entries')
          .add(data);
      debugPrint('✅ Video log uploaded for $category');
    } catch (e) {
      debugPrint('❌ Video log upload failed, queued. $e');
      await OfflineSyncQueue.addTask(
        SyncTask(type: 'video_log', data: data, timestamp: DateTime.now()),
      );
    }
  }
}
