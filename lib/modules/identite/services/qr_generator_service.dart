/// Copilot Prompt : QRGeneratorService pour AniSphère.
/// Génère un QR code pointant vers une page publique Firebase d’un animal.
/// Utilise qr_flutter pour affichage local, Firebase pour publication différée.
library;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

/// QRGeneratorService pour AniSphère.
/// Génère un QR code pointant vers une page publique Firebase d’un animal.
/// Utilise qr_flutter pour affichage local, Firebase pour publication différée.

class QRGeneratorService {
  final FirebaseFirestore firestore;

  QRGeneratorService({FirebaseFirestore? instance})
      : firestore = instance ?? FirebaseFirestore.instance;

  /// Publie les infos publiques sur Firestore et retourne l’URL publique
  Future<String> publishPublicIdentity({
    required String animalId,
    required Map<String, dynamic> publicData,
  }) async {
    final docRef = firestore.collection('public_identities').doc(animalId);
    await docRef.set({
      ...publicData,
      'publishedAt': FieldValue.serverTimestamp(),
    });
    return 'https://anisphere.app/animal/$animalId';
  }

  /// Widget QR Code à afficher dans l’écran de profil
  Widget buildQRCode(String publicUrl, {double size = 160.0}) {
    return QrImageView(
      data: publicUrl,
      version: QrVersions.auto,
      size: size,
      gapless: false,
      backgroundColor: Colors.white,
    );
  }
}
