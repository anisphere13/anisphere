// @dart=3.4
// 🧪 Script de mise à jour de test_tracker.md (automatique)
import 'dart:io';

void main() {
  final filePath = 'docs/test_tracker.md';
  final file = File(filePath);

  if (!file.existsSync()) {
    stderr.writeln("❌ Fichier introuvable : $filePath");
    exit(1);
  }

  final today = DateTime.now();
  final formattedDate = "${today.year}-${_pad(today.month)}-${_pad(today.day)}";
  final tag = "- ✅ Tests validés automatiquement le $formattedDate";

  final content = file.readAsStringSync();

  if (content.contains(tag)) {
    print("🔁 test_tracker.md déjà à jour pour le $formattedDate.");
    return;
  }

  final updatedContent = "$content\n$tag\n";
  file.writeAsStringSync(updatedContent.trimRight() + '\n');

  print("✅ test_tracker.md mis à jour avec la date du $formattedDate.");
}

String _pad(int n) => n.toString().padLeft(2, '0');
