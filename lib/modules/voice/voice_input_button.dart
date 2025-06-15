// Copilot: Widget bouton microphone pour lancer l'écoute vocale
library;

import 'package:flutter/material.dart';

class VoiceInputButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool listening;
  const VoiceInputButton({super.key, required this.onPressed, this.listening = false});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 48,
      icon: Icon(listening ? Icons.mic : Icons.mic_none,
          color: listening ? Colors.red : Colors.grey),
      onPressed: onPressed,
    );
  }
}
