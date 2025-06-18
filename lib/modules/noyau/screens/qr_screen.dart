// Copilot Prompt : Écran QR pour AniSphère.
// Permet de scanner un QR code ou de générer un QR lié à l’utilisateur ou à un animal.
// Utilise mobile_scanner + QRService. Préparé pour la synchronisation IA via QR.

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import 'package:anisphere/modules/noyau/services/qr_service.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({super.key});

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _scanResult;
  final MobileScannerController _scannerController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _handleScan(String result) {
    if (result != _scanResult) {
      setState(() => _scanResult = result);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("QR scanné : $result")),
      );
      // Ici : synchronisation IA ou traitement personnalisé
    }
  }

  @override
  void dispose() {
    _scannerController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Sync"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.qr_code_scanner), text: "Scanner"),
            Tab(icon: Icon(Icons.qr_code), text: "Mon QR"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ✅ Scanner mobile_scanner intégré
          MobileScanner(
            controller: _scannerController,
            onDetect: (capture) {
              final barcode = capture.barcodes.first;
              final value = barcode.rawValue;
              if (value != null) _handleScan(value);
            },
          ),

          // ✅ Générateur QR selon l'utilisateur
          Center(
            child: user != null
                ? QRService.generateQRCode("anisphere:user:${user.id}")
                : const Text("Utilisateur non connecté."),
          ),
        ],
      ),
    );
  }
}
