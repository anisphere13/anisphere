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
    final father = RegExp(r'Father ID[:\s]*([\w-]+)', caseSensitive: false)
        .firstMatch(text);
    final mother = RegExp(r'Mother ID[:\s]*([\w-]+)', caseSensitive: false)
        .firstMatch(text);

    if (father != null) data['fatherId'] = father.group(1)!;
    if (mother != null) data['motherId'] = mother.group(1)!;
    return data;
  }

  void dispose() {
    _recognizer.close();
  }
}
