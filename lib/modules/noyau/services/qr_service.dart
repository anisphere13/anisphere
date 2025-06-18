// Copilot Prompt : Service de QR code pour AniSphère.
// Génère des QR codes (texte, URL, ID), et intègre un scanner mobile.
// Utilise qr_flutter pour l'affichage, mobile_scanner pour la lecture.
// Prévu pour la synchronisation d’animaux, d'utilisateurs et de partages IA.

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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

  /// 🔍 Affiche un scanner QR intégré
  /// Utilise `mobile_scanner`, nécessite un `controller` externe
  static Widget buildQRScanner({
    required void Function(String result) onScanned,
    MobileScannerController? controller,
  }) {
    final MobileScannerController effectiveController =
        controller ?? MobileScannerController();

    return MobileScanner(
      controller: effectiveController,
      onDetect: (capture) {
        final barcode = capture.barcodes.first;
        final value = barcode.rawValue;
        if (value != null) {
          onScanned(value);
          // Log debug uniquement
          assert(() {
            debugPrint("📷 QR scanné : $value");
            return true;
          }());
        }
      },
    );
  }
}

