// Copilot Prompt : Générer un modèle universel de PDF export pour AniSphère.
// Utilisé comme template commun à tous les modules (Identité, Santé, etc.)

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Champ dynamique à afficher dans une section d'export.
class ExportField {
  final String label;
  final String value;
  ExportField({required this.label, required this.value});
}

/// Section regroupant un titre et plusieurs champs d'export.
class ExportSection {
  final String title;
  final List<ExportField> fields;
  ExportSection({required this.title, required this.fields});
}

/// Construit un PDF commun pour l'export des modules AniSphère.
/// [moduleName] et [moduleIcon] personnalisent l'entête.
/// [sections] contient les données à afficher.
/// [logoBytes] et [qrCodeBytes] sont des images au format bytes.
Future<Uint8List> buildModuleExportPdf({
  required String moduleName,
  required IconData moduleIcon,
  required List<ExportSection> sections,
  required Uint8List logoBytes,
  required Uint8List qrCodeBytes,
}) async {
  final doc = pw.Document();
  final mainColor = PdfColor.fromInt(0xFF183153);
  final logo = pw.MemoryImage(logoBytes);
  final qr = pw.MemoryImage(qrCodeBytes);
  final date = DateFormat('dd/MM/yyyy').format(DateTime.now());

  doc.addPage(
    pw.MultiPage(
      margin: const pw.EdgeInsets.all(24),
      build: (context) => [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.UrlLink(
              destination: 'https://anisphere.app',
              child: pw.Image(logo, width: 40),
            ),
            pw.Row(
              children: [
                pw.Icon(pw.IconData(moduleIcon.codePoint), color: mainColor),
                pw.SizedBox(width: 8),
                pw.Text(
                  moduleName,
                  style: pw.TextStyle(
                    color: mainColor,
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
            pw.SizedBox(width: 40),
          ],
        ),
        pw.SizedBox(height: 12),
        for (final section in sections) ...[
          pw.Container(
            width: double.infinity,
            color: const PdfColor.fromInt(0xFFF5F5F5),
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text(
              section.title,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                color: mainColor,
              ),
            ),
          ),
          pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
            },
            children: [
              for (final field in section.fields)
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 4),
                    child: pw.Text(field.label),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 4),
                    child: pw.Text(field.value),
                  ),
                ])
            ],
          ),
          pw.SizedBox(height: 12),
        ],
        pw.SizedBox(height: 20),
        pw.Center(
          child: pw.UrlLink(
            destination: 'https://anisphere.app',
            child: pw.Image(qr, width: 100),
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Center(
          child: pw.Text(
            'Partagé avec ❤️ depuis AniSphère',
            style: pw.TextStyle(color: mainColor),
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Center(
          child: pw.Text(
            'Exporté le $date',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey),
          ),
        ),
      ],
    ),
  );

  return doc.save();
}

