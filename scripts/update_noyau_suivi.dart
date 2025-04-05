// 🧠 Script de suivi du noyau (noyau_suivi.md)
import 'dart:io';

void main() {
  final file = File('docs/noyau_suivi.md');
  if (!file.existsSync()) {
    stderr.writeln("❌ noyau_suivi.md introuvable !");
    return;
  }

  String content = file.readAsStringSync();
  if (!content.contains("2025-04-05")) {
    content += "\n- 🧩 Synchronisation automatique du noyau le 2025-04-05";
    file.writeAsStringSync(content);
    stderr.writeln("✅ noyau_suivi.md mis à jour !");
  } else {
    stderr.writeln("🔁 noyau_suivi.md déjà synchronisé pour aujourd'hui.");
  }
}
