// @dart=3.4
// 🧠 Script de mise à jour automatique de noyau_suivi.md
import 'dart:io';

void main() {
  const filePath = 'docs/noyau_suivi.md';
  final file = File(filePath);

  if (!file.existsSync()) {
    stderr.writeln("❌ Fichier introuvable : $filePath");
    exit(1);
  }

  final today = DateTime.now();
  final formattedDate = "${today.year}-${_pad(today.month)}-${_pad(today.day)}";
  final tag = "- 🧩 Synchronisation automatique du noyau le $formattedDate";

  final content = file.readAsStringSync();

  if (content.contains(tag)) {
    stdout.writeln("🔁 $filePath déjà synchronisé pour le $formattedDate.");
    return;
  }

  final updatedContent = "$content\n$tag\n";
  file.writeAsStringSync('${updatedContent.trimRight()}\n');

  stdout.writeln("✅ $filePath mis à jour avec la date du $formattedDate.");
}

String _pad(int n) => n.toString().padLeft(2, '0');
