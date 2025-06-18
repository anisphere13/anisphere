import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Télécharge les modèles IA depuis Firebase Storage et les stocke localement.
class IaModelUpdater {
  final FirebaseStorage storage;

  IaModelUpdater({FirebaseStorage? storage})
    : storage = storage ?? FirebaseStorage.instance;

  Future<File> download(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final bytes = await storage.ref('ia_models/$fileName').getData();
    final file = File(p.join(dir.path, 'models', fileName));
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes ?? []);
    return file;
  }
}
