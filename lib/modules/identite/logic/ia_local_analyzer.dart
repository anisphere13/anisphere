library;

import 'dart:io';

import '../../noyau/logic/module_analyzer.dart';
import '../services/ocr_icad_service.dart';
import '../services/photo_verification_service.dart';

/// Input data for [IdentityLocalAnalyzer].
class IdentityAnalysisInput {
  final File? documentImage;
  final File? photo;

  IdentityAnalysisInput({this.documentImage, this.photo});
}

/// Local analyzer for the Identité module.
class IdentityLocalAnalyzer extends ModuleAnalyzer<IdentityAnalysisInput, Map<String, dynamic>> {
  final OCRICADService ocrService;
  final PhotoVerificationService photoService;

  IdentityLocalAnalyzer({
    OCRICADService? ocrService,
    PhotoVerificationService? photoService,
  })  : ocrService = ocrService ?? OCRICADService(),
        photoService = photoService ?? PhotoVerificationService();

  @override
  Future<Map<String, dynamic>> analyze(IdentityAnalysisInput input) async {
    final result = <String, dynamic>{};

    if (input.documentImage != null) {
      final data = await ocrService.extractIdentityData(input.documentImage!);
      result['ocr'] = data;
    }

    if (input.photo != null) {
      final score = await photoService.scorePhoto(input.photo!);
      result['photoScore'] = score;
    }

    return result;
  }
}

