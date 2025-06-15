// Copilot: Page mains-libres affichant l'état d'écoute vocale
library;

import 'package:flutter/material.dart';
import '../services/speech_recognition_service.dart';
import '../widgets/voice_input_button.dart';

class VoiceHandsfreeMode extends StatefulWidget {
  const VoiceHandsfreeMode({super.key});

  @override
  State<VoiceHandsfreeMode> createState() => _VoiceHandsfreeModeState();
}

class _VoiceHandsfreeModeState extends State<VoiceHandsfreeMode> {
  final SpeechRecognitionService _service = SpeechRecognitionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mode vocal')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_service.isListening ? 'Écoute en cours...' : 'Appuyez pour parler'),
            const SizedBox(height: 16),
            VoiceInputButton(
              listening: _service.isListening,
              onPressed: () async {
                if (_service.isListening) {
                  await _service.stopListening();
                } else {
                  await _service.startListening();
                }
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            Text(_service.getTranscription()),
          ],
        ),
      ),
    );
  }
}
