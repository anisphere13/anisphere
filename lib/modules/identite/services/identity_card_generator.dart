// Copilot Prompt : Générateur PDF pour mini-carte d’identité AniSphère.
// Crée un PDF format CB (85x54 mm) avec nom, puce, photo, QR code.
// Utilise `pdf` pour génération, preview ou export via un autre service.
// TODO: Export PDF premium
library;
import 'dart:io';
import 'dart:typed_data'; // ✅ Nécessaire pour Uint8List
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../models/identity_model.dart';

/// Générateur PDF pour mini-carte d’identité AniSphère.
/// Crée un PDF format CB (85x54 mm) avec nom, puce, photo, QR code.
/// Utilise `pdf` pour génération, preview ou export via un autre service.

class IdentityCardGenerator {
  Future<Uint8List> generateCard({
    required IdentityModel identity,
    required String animalName,
    required String qrUrl,
    File? photo,
  }) async {
    final doc = pw.Document();

    final photoImage = photo != null
        ? pw.MemoryImage(await photo.readAsBytes())
        : null;

    doc.addPage(
      pw.Page(
        pageFormat: const PdfPageFormat(85 * PdfPageFormat.mm, 54 * PdfPageFormat.mm),
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey800),
            ),
            padding: const pw.EdgeInsets.all(6),
            child: pw.Row(
              children: [
                if (photoImage != null)
                  pw.Container(
                    width: 40,
                    height: 40,
                    child: pw.Image(photoImage),
                  ),
                pw.SizedBox(width: 8),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        animalName,
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      if (identity.microchipNumber != null)
                        pw.Text(
                          "Puce : ${identity.microchipNumber}",
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      if (identity.status != null)
                        pw.Text(
                          "Statut : ${identity.status}",
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      if (identity.legalStatus != null)
                        pw.Text(
                          "Type : ${identity.legalStatus}",
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                    ],
                  ),
                ),
                pw.BarcodeWidget(
                  data: qrUrl,
                  width: 40,
                  height: 40,
                  barcode: pw.Barcode.qrCode(),
                ),
              ],
            ),
          );
        },
      ),
    );

    return await doc.save();
  }
}
