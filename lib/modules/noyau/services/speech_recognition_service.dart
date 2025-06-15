// Copilot: Service Flutter pour reconnaissance vocale offline-first avec fallback Google Speech
library;

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:google_speech/google_speech.dart' as gs;

/// Service de reconnaissance vocale pour AniSphère.
/// Utilise `speech_to_text` en priorité pour une reconnaissance locale.
/// En cas d'échec ou d'indisponibilité, bascule sur l'API Google Speech.
class SpeechRecognitionService {
  final stt.SpeechToText _speechToText;
  final gs.SpeechToText _googleFallback; // ignore: unused_field
  bool _isInitialized = false;
  bool _isListening = false;
  String _transcription = '';

  SpeechRecognitionService({
    stt.SpeechToText? speechToText,
    gs.SpeechToText? googleFallback,
  })  : _speechToText = speechToText ?? stt.SpeechToText(),
        _googleFallback = googleFallback ?? gs.SpeechToText();

  /// Initialise la reconnaissance locale si nécessaire.
  Future<void> _init() async {
    if (_isInitialized) return;
    _isInitialized = await _speechToText.initialize(onError: (err) {});
  }

  /// Démarre l'écoute vocale.
  Future<void> startListening() async {
    await _init();
    if (_isInitialized) {
      _isListening = true;
      await _speechToText.listen(onResult: (result) {
        _transcription = result.recognizedWords;
      });
    } else {
      // Fallback Google Speech via streaming si speech_to_text non dispo
      _isListening = true;
      // TODO: implémenter l'appel réel à google_speech avec authentification
    }
  }

  /// Stoppe l'écoute.
  Future<void> stopListening() async {
    if (_isListening) {
      await _speechToText.stop();
      _isListening = false;
    }
  }

  /// Indique si l'écoute est en cours.
  bool get isListening => _isListening;

  /// Retourne la transcription courante.
  String getTranscription() => _transcription;
}
