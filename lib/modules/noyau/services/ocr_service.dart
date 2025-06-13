// Copilot Prompt : OCRService générique pour AniSphère.
// Utilise Google ML Kit pour extraire le texte d'une image locale.

library;

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRService {
  final TextRecognizer _recognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  /// Analyse l'image et retourne le texte brut reconnu.
  Future<String> extractText(File file) async {
    try {
      final input = InputImage.fromFile(file);
      final result = await _recognizer.processImage(input);
      return result.text;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ [OCRService] Erreur OCR : $e');
      }
      return '';
    }
  }

  void dispose() {
    _recognizer.close();
  }
}
