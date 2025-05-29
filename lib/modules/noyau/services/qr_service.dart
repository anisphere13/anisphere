/// Copilot Prompt : Service de QR code pour AniSphère.
/// Permet de générer des QR codes (textes, URL, ID), et de les scanner.
/// Utilise les packages qr_flutter pour l'affichage et qr_code_scanner pour la lecture.
/// Prévu pour la synchronisation d’animaux, d'utilisateurs et de partages IA.

library;

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRService {
  /// 🔹 Génère un widget de QR code à partir d'une donnée texte
  static Widget generateQRCode(String data, {double size = 200}) {
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: size,
      gapless: false,
    );
  }

  /// 🔍 Affiche un scanner QR intégré dans une page
  /// Nécessite de gérer la logique du résultat via le callback `onScanned`
  static Widget buildQRScanner({
    required void Function(String result) onScanned,
  }) {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    return QRView(
      key: qrKey,
      onQRViewCreated: (QRViewController controller) {
        controller.scannedDataStream.listen((scanData) {
          controller.pauseCamera(); // Évite les doublons
          onScanned(scanData.code ?? "");
          // Log uniquement en debug
          assert(() {
            debugPrint("📷 QR scanné : ${scanData.code}");
            return true;
          }());
        });
      },
      overlay: QrScannerOverlayShape(
        borderColor: Colors.purple,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 8,
        cutOutSize: 280,
      ),
    );
  }
}
