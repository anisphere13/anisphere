// Copilot Prompt : Service de partage local (Bluetooth/Wi-Fi Direct/NFC/QR) pour AniSphère.
// Détecte automatiquement les modes disponibles et assure la transmission locale de fichiers.
// Fournit également une méthode de partage via QR pour passer un lien ou identifiant.
library;

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:nearby_connections/nearby_connections.dart';

import 'qr_service.dart';

class LocalSharingService {
  final FlutterBluePlus _bluetooth;
  final NearbyService _nearby;

  LocalSharingService({
    FlutterBluePlus? bluetooth,
    NearbyService? nearby,
  })  : _bluetooth = bluetooth ?? FlutterBluePlus.instance,
        _nearby = nearby ?? NearbyService();

  /// 📤 Envoie un fichier vers un appareil à proximité.
  /// Tente Wi‑Fi Direct via `nearby_connections`, puis Bluetooth.
  Future<bool> sendFileNearby(File file) async {
    if (await _sendViaNearby(file)) return true;
    if (await _sendViaBluetooth(file)) return true;
    debugPrint('❌ [LocalShare] Aucun mode disponible pour envoyer ${file.path}');
    return false;
  }

  /// 📥 Attend la réception d’un fichier proche.
  /// Retourne le fichier stocké localement ou `null` si aucun transfert réussi.
  Future<File?> receiveFileNearby() async {
    final nearby = await _receiveViaNearby();
    if (nearby != null) return nearby;
    return await _receiveViaBluetooth();
  }

  /// 📱 Génère un QR code pour partager un texte/lien (fallback universel).
  Widget shareViaQR(String data, {double size = 200}) {
    return QRService.generateQRCode(data, size: size);
  }

  // --- Méthodes internes ---
  Future<bool> _sendViaNearby(File file) async {
    try {
      final hasPermission = await _nearby.checkLocationPermission();
      if (!hasPermission) return false;
      await _nearby.startAdvertising('AniSphere', Strategy.P2P_CLUSTER);
      // Simplifié : envoie direct sans gestion avancée de connexion
      await _nearby.sendFilePath('AniSphere', file.path);
      await _nearby.stopAdvertising();
      debugPrint('📡 [LocalShare] Fichier envoyé via Nearby');
      return true;
    } catch (e) {
      debugPrint('❌ [LocalShare] Nearby échec : $e');
      return false;
    }
  }

  Future<bool> _sendViaBluetooth(File file) async {
    try {
      final isOn = await _bluetooth.isOn;
      if (!isOn) return false;
      // Simplifié : broadcast basique du fichier
      // Un vrai échange nécessiterait un service GATT spécifique
      debugPrint('📶 [LocalShare] Envoi Bluetooth non implémenté');
      return false;
    } catch (e) {
      debugPrint('❌ [LocalShare] Bluetooth échec : $e');
      return false;
    }
  }

  Future<File?> _receiveViaNearby() async {
    try {
      final hasPermission = await _nearby.checkLocationPermission();
      if (!hasPermission) return null;
      await _nearby.startBrowsingForPeers();
      // Simplifié : récupération du premier fichier reçu
      final file = await _nearby.receiveFile();
      await _nearby.stopBrowsingForPeers();
      if (file != null) {
        debugPrint('📡 [LocalShare] Fichier reçu via Nearby');
        return File(file.path);
      }
    } catch (e) {
      debugPrint('❌ [LocalShare] Réception Nearby échec : $e');
    }
    return null;
  }

  Future<File?> _receiveViaBluetooth() async {
    try {
      final isOn = await _bluetooth.isOn;
      if (!isOn) return null;
      debugPrint('📶 [LocalShare] Réception Bluetooth non implémentée');
    } catch (e) {
      debugPrint('❌ [LocalShare] Réception Bluetooth échec : $e');
    }
    return null;
  }
}
