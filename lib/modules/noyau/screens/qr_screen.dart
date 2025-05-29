/// Copilot Prompt : Écran QR pour AniSphère.
/// Permet de scanner un QR code ou de générer un QR lié à l’utilisateur ou à un animal.
/// Utilise QRService pour l’UI. Préparé pour la synchronisation IA via QR.

library;

import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/services/qr_service.dart';
import 'package:provider/provider.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({super.key});

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _scanResult;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _handleScan(String result) {
    setState(() {
      _scanResult = result;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("QR scanné : $result")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Sync"),
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.qr_code_scanner), text: "Scanner"),
            Tab(icon: Icon(Icons.qr_code), text: "Mon QR"),
          ],
        ),
        bottomOpacity: 1.0,
        backgroundColor: const Color(0xFF183153),
        foregroundColor: Colors.white,
        controller: _tabController,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Onglet scanner
          QRService.buildQRScanner(onScanned: _handleScan),
          // Onglet générateur
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
