/// Copilot Prompt : OCRICADService pour AniSphère.
/// Analyse les documents I-CAD, LOF, carnet papier.
/// Extrait puce, nom, race, dates, identifiants via OCR (Tesseract + RegEx).
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRICADService {
  final textRecognizer = TextRecognizer();

  Future<Map<String, String>> extractIdentityData(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final recognisedText = await textRecognizer.processImage(inputImage);

    final rawText = recognisedText.text;
    final data = <String, String>{};

    // Expressions régulières typiques I-CAD / LOF
    final microchipMatch = RegExp(r'(\d{15})').firstMatch(rawText);
    final nameMatch = RegExp(r'(Nom|Name)[\s:]*([A-Z][a-zA-Z-]+)').firstMatch(rawText);
    final raceMatch = RegExp(r'(Race|Breed)[\s:]*([A-Z][a-zA-Z-]+)').firstMatch(rawText);
    final dateMatch = RegExp(r'(\d{2}/\d{2}/\d{4})').firstMatch(rawText);

    if (microchipMatch != null) {
      data['microchipNumber'] = microchipMatch.group(1)!;
    }
    if (nameMatch != null) {
      data['name'] = nameMatch.group(2)!;
    }
    if (raceMatch != null) {
      data['race'] = raceMatch.group(2)!;
    }
    if (dateMatch != null) {
      data['birthdate'] = dateMatch.group(1)!;
    }

    return data;
  }

  void dispose() {
    textRecognizer.close();
  }
}
