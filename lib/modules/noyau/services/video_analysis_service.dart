// Analyse Vidéo AniSphère

import 'dart:io';
import 'package:flutter/foundation.dart';

import 'video_analysis_config.dart';
import 'video_logs_collector.dart';
import 'cloud_sync_service.dart';

/// Service d'analyse vidéo et d'envoi au cloud si activé.
class VideoAnalysisService {
  final CloudSyncService _cloudSyncService;

  VideoAnalysisService({CloudSyncService? cloudSyncService})
      : _cloudSyncService = cloudSyncService ?? CloudSyncService();

  /// Prépare et envoie une vidéo pour analyse cloud.
  Future<void> uploadForAnalysis(File file,
      {required String module, required String videoId}) async {
    if (!kEnableVideoCloudAnalysis) {
      debugPrint('⚠️ Analyse vidéo cloud désactivée.');
      throw Exception('Cloud analysis for videos is disabled.');
    }

    // TODO: activer lorsque l'option sera validée.
    // final compressed = await StorageOptimizer.compressVideo(file);
    // final result = await _cloudSyncService.uploadVideoForAnalysis(
    //   compressed ?? file,
    //   module: module,
    //   videoId: videoId,
    // );
    // await file.delete();
    // await VideoLogsCollector.save(
    //   module: module,
    //   videoId: videoId,
    //   results: result,
    // );
  }
}
