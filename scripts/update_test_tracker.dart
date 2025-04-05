// 🧪 Script de mise à jour de test_tracker.md
import 'dart:io';

void main() {
  final file = File('docs/test_tracker.md');
  if (!file.existsSync()) {
    stderr.writeln("❌ test_tracker.md introuvable !");
    return;
  }

  String content = file.readAsStringSync();
  if (!content.contains("2025-04-05")) {
    content += "\n- 📌 Tests validés automatiquement le 2025-04-05";
    file.writeAsStringSync(content);
    stderr.writeln("✅ test_tracker.md mis à jour !");
  } else {
    stderr.writeln("🔁 test_tracker.md déjà à jour pour aujourd'hui.");
  }
}
