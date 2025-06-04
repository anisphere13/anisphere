// @dart=3.4
// 🧪 Script de mise à jour de test_tracker.md selon les tests présents

import 'dart:io';

Future<void> main() async {
  const srcPath = 'test/test_tracker.md';
  const destPath = 'docs/test_tracker.md';

  final srcFile = File(srcPath);
  final destFile = File(destPath);

  if (!srcFile.existsSync()) {
    stderr.writeln('❌ Fichier introuvable : $srcPath');
    exit(1);
  }

  final processedLines = _processTracker(srcFile.readAsLinesSync());

  final today = DateTime.now();
  final formattedDate =
      '${today.year}-${_pad(today.month)}-${_pad(today.day)}';
  final tag = '- ✅ Tests validés automatiquement le $formattedDate';

  destFile
      .writeAsStringSync('${processedLines.join('\n')}\n\n$tag\n');
  srcFile.writeAsStringSync('${processedLines.join('\n')}\n');

  final updatedContent = "$content\n$tag\n";
  file.writeAsStringSync('${updatedContent.trimRight()}\n');

List<String> _processTracker(List<String> lines) {
  if (lines.length <= 3) return lines; // headers only
  final headers = lines.take(3).toList();
  final entries = lines.skip(3).map((line) {
    final trimmed = line.trim();
    if (!trimmed.startsWith('|')) return line.trimRight();

    final cells =
        trimmed.substring(1, trimmed.length - 1).split('|').map((e) => e.trim()).toList();
    if (cells.length < 4) return line.trimRight();

    final testFile = File(cells[0]);
    cells[3] = testFile.existsSync() ? '✅' : 'À faire';
    return '| ${cells.join(' | ')} |';
  }).toList();
  return [...headers, ...entries];
}

String _pad(int n) => n.toString().padLeft(2, '0');