// @dart=3.4
// 🔄 Script de mise à jour automatique de suivi_taches.md
import 'dart:io';

void main() {
  final file = File('docs/3__suivi_taches.md');
  if (!file.existsSync()) {
    stderr.writeln("❌ Fichier non trouvé !");
    return;
  }

  String content = file.readAsStringSync();
  if (!content.contains("2025-04-05")) {
    content += "\n- ✅ Mise à jour automatique des tâches le 2025-04-05";
    file.writeAsStringSync(content);
    stderr.writeln("✅ suivi_taches.md mis à jour !");
  } else {
    stderr.writeln("🔁 Rien à mettre à jour (déjà présent pour aujourd'hui).");
  }
}
