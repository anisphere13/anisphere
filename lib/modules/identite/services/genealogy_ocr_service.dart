import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// Service parsing genealogy information from a document.
class GenealogyOCRService {
  final TextRecognizer _recognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  Future<Map<String, String>> extractGenealogyData(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final text = await _recognizer.processImage(inputImage);
    return parseText(text.text);
  }

  /// Visible for testing
  Map<String, String> parseText(String text) {
    final Map<String, String> data = {};
    final father =
        RegExp(r'Father[:\s]*([\w\s-]+)', caseSensitive: false).firstMatch(text);
    final mother =
        RegExp(r'Mother[:\s]*([\w\s-]+)', caseSensitive: false).firstMatch(text);

    if (father != null) data['fatherName'] = father.group(1)!.trim();
    if (mother != null) data['motherName'] = mother.group(1)!.trim();
    return data;
  }

  void dispose() {
    _recognizer.close();
  }
}
