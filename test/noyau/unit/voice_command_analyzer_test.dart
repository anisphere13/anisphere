import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:anisphere/modules/noyau/logic/voice_command_analyzer.dart';

void main() {
  test('analyze detects addReminder', () {
    final analyzer = VoiceCommandAnalyzer();
    final command = analyzer.analyze('Peux-tu ajouter rappel pour demain');
    expect(command.action, VoiceAction.addReminder);
  });
}
