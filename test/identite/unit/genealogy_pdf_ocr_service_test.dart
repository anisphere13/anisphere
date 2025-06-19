import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/services/genealogy_pdf_ocr_service.dart';

void main() {
  const channel = MethodChannel('tesseract_ocr');
  final List<MethodCall> log = [];
  late File tempFile;

  setUpAll(() async {
    await initTestEnv();
    tempFile = await File('${Directory.systemTemp.path}/dummy.pdf').create();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
      log.add(call);
      if (call.method == 'extractText') {
        return 'Père: F123\nMère: M456\nAffixe: AFF\nPortée: L99';
      }
      return null;
    });
  });

  tearDownAll(() async {
    await tempFile.delete();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('extractGenealogyData parses pdf OCR output', () async {
    final service = GenealogyPdfOcrService();
    final result = await service.extractGenealogyData(tempFile);
    expect(result['fatherName'], 'F123');
    expect(result['motherName'], 'M456');
    expect(result['affixe'], 'AFF');
    expect(result['litterNumber'], 'L99');
    expect(log.any((c) => c.method == 'extractText'), isTrue);
  });
}
