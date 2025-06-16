// Copilot Prompt : Générateur PDF premium de passeport visuel pour AniSphère.
// Produit un document stylisé multilingue (nom, puce, photo, statut, QR, historique)
// réservé aux utilisateurs premium. Export PDF prêt à partager.
// TODO: Export PDF premium
library;
import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../models/identity_model.dart';

/// Générateur PDF premium de passeport visuel pour AniSphère.
/// Produit un document stylisé multilingue (nom, puce, photo, statut, QR, historique)
/// réservé aux utilisateurs premium. Export PDF prêt à partager.

class IdentityPassportGenerator {
  Future<Uint8List> generatePremiumPassport({
    required IdentityModel identity,
    required String animalName,
    required File? photo,
    required String qrUrl,
  }) async {
    final doc = pw.Document();

    final photoImage = photo != null
        ? pw.MemoryImage(await photo.readAsBytes())
        : null;

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(
                "Passeport d'identité – $animalName",
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (photoImage != null)
                  pw.Container(
                    width: 100,
                    height: 100,
                    margin: const pw.EdgeInsets.only(right: 20),
                    child: pw.Image(photoImage),
                  ),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Nom : $animalName"),
                      if (identity.microchipNumber != null)
                        pw.Text("Numéro de puce : ${identity.microchipNumber}"),
                      if (identity.status != null)
                        pw.Text("Statut : ${identity.status}"),
                      if (identity.legalStatus != null)
                        pw.Text("Type : ${identity.legalStatus}"),
                      pw.Text(
                        "Dernière mise à jour : ${identity.lastUpdate.toLocal().toIso8601String().substring(0, 10)}",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text("QR Code d'identification :"),
            pw.BarcodeWidget(
              data: qrUrl,
              barcode: pw.Barcode.qrCode(),
              width: 120,
              height: 120,
            ),
            if (identity.history.isNotEmpty) ...[
              pw.SizedBox(height: 20),
              pw.Text("Historique des modifications :", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: identity.history.map((e) {
                  final date = e.date.toLocal().toIso8601String().substring(0, 10);
                  return pw.Bullet(
                    text: "$date : ${e.field} modifié de '${e.oldValue}' → '${e.newValue}'",
                  );
                }).toList(),
              ),
            ],
          ];
        },
      ),
    );

    return await doc.save();
  }
}
