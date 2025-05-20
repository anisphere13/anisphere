// @dart=3.4
// 🔄 Script de mise à jour automatique de suivi_taches.md
import 'dart:io';

void main() {
  final filePath = 'docs/3__suivi_taches.md';
  final file = File(filePath);

  if (!file.existsSync()) {
    stderr.writeln("❌ Fichier introuvable : $filePath");
    exit(1);
  }

  final today = DateTime.now();
  final formattedDate = "${today.year}-${_pad(today.month)}-${_pad(today.day)}";
  final tag = "- ✅ Mise à jour automatique des tâches le $formattedDate";

  final content = file.readAsStringSync();

  if (content.contains(tag)) {
    print("🔁 $filePath déjà à jour pour le $formattedDate.");
    return;
  }

  final updatedContent = "$content\n$tag\n";
  file.writeAsStringSync('${updatedContent.trimRight()}\n');

  print("✅ $filePath mis à jour avec la date du $formattedDate.");
}

String _pad(int n) => n.toString().padLeft(2, '0');
