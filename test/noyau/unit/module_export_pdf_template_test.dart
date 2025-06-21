import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/services/pdf/pdf_export_template.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('buildModuleExportPdf returns PDF bytes', () async {
    final pdf = await buildModuleExportPdf(
      moduleName: 'Test',
      moduleIcon: Icons.pets,
      sections: [
        ExportSection(
          title: 'Infos',
          fields: [
            ExportField(label: 'Nom', value: 'Luna'),
          ],
        ),
      ],
      logoBytes: Uint8List.fromList([1, 2, 3]),
      qrCodeBytes: Uint8List.fromList([4, 5, 6]),
    );

    expect(pdf.lengthInBytes, greaterThan(100));
  });
}
