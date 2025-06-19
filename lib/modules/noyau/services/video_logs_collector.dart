// Analyse Vidéo AniSphère

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Stocke les résultats IA des vidéos dans logs_ia/<module>.
class VideoLogsCollector {
  static Future<void> save({
    required String module,
    required String videoId,
    required Map<String, dynamic> results,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final moduleDir = Directory(p.join(dir.path, 'logs_ia', module));
    await moduleDir.create(recursive: true);
    final file = File(p.join(moduleDir.path, '$videoId.json'));
    await file.writeAsString(jsonEncode(results));
    if (kDebugMode) {
      debugPrint('📝 Résultats vidéo sauvegardés : ${file.path}');
    }
  }
}
