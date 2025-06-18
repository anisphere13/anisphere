// fix: update file handling for FlutterImageCompress (XFile -> File)
// and remove unused imports.

import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

/// Service d'optimisation du stockage pour AniSphère.
/// Compresse les images avant upload et calcule un hash
/// pour détecter les doublons.
class StorageOptimizer {
  /// 📉 Compresse une image et retourne le fichier compressé.
  static Future<File?> compressImage(File file, {int quality = 75}) async {
    try {
      final idx = file.path.lastIndexOf('.');
      final targetPath = idx != -1
          ? '${file.path.substring(0, idx)}_compressed${file.path.substring(idx)}'
          : '${file.path}_compressed';
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: quality,
      );
      if (result != null) {
        final size = await result.length();
        assert(() {
          debugPrint('📦 Image compressée : ${file.path} -> $size o');
          return true;
        }());
      }
      return result != null ? File(result.path) : null;
    } catch (e) {
      debugPrint('❌ [StorageOptimizer] Erreur compression : $e');
      return null;
    }
  }

  /// 🔑 Calcule un hash MD5 pour le fichier fourni.
  static Future<String> computeHash(File file) async {
    try {
      final bytes = await file.readAsBytes();
      return md5.convert(bytes).toString();
    } catch (e) {
      debugPrint('❌ [StorageOptimizer] Erreur calcul hash : $e');
      return '';
    }
  }

  /// 🗜️ Optimise une liste de chemins de fichiers.
  /// Les images sont compressées puis dédupliquées grâce au hash.
  static Future<List<String>> optimizePaths(List<String> paths, {int quality = 75}) async {
    final seen = <String>{};
    final results = <String>[];
    for (final path in paths) {
      final file = File(path);
      if (!await file.exists()) continue;
      final compressed = await compressImage(file, quality: quality);
      final toHash = compressed ?? file;
      final hash = await computeHash(toHash);
      if (seen.add(hash)) {
        results.add(toHash.path);
      }
    }
    return results;
  }
}
