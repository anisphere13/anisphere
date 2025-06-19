import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:tesseract_ocr/tesseract_ocr.dart';

/// Service performing OCR on genealogy PDF documents using Tesseract.
/// Parsed values are extracted with regular expressions.
class GenealogyPdfOcrService {
  Future<Map<String, String>> extractGenealogyData(File pdfFile) async {
    try {
      final text = await TesseractOcr.extractText(pdfFile.path);
      final data = <String, String>{};

      final fatherMatch =
          RegExp(r'P\u00e8?re[:\s]*([\w\s-]+)', caseSensitive: false).firstMatch(text);
      final motherMatch =
          RegExp(r'M\u00e8?re[:\s]*([\w\s-]+)', caseSensitive: false).firstMatch(text);
      final affixeMatch =
          RegExp(r'Affixe[:\s]*([\w-]+)', caseSensitive: false).firstMatch(text);
      final litterMatch = RegExp(r'Port\w*[:\s]*(\w+)', caseSensitive: false)
          .firstMatch(text);
      final lofMatch =
          RegExp(r'LOF[:\s]*([\w-]+)', caseSensitive: false).firstMatch(text);

      if (fatherMatch != null) data['fatherName'] = fatherMatch.group(1)!.trim();
      if (motherMatch != null) data['motherName'] = motherMatch.group(1)!.trim();
      if (affixeMatch != null) data['affixe'] = affixeMatch.group(1)!;
      if (litterMatch != null) data['litterNumber'] = litterMatch.group(1)!;
      if (lofMatch != null) data['lofName'] = lofMatch.group(1)!;

      return data;
    } catch (e) {
      if (kDebugMode) {
        print('❌ [GenealogyPdfOcrService] $e');
      }
      return {};
    }
  }
}
