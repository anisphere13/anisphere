import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class IaModelLoader {
  static Future<File> loadModel(String assetPath, {Directory? docsDir}) async {
    final dir = docsDir ?? await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, assetPath));
    if (await file.exists()) {
      return file;
    }
    final data = await rootBundle.load('assets/$assetPath');
    await file.parent.create(recursive: true);
    await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
    return file;
  }
}
