// Copilot Prompt : Écran de partage AniSphère.
// Permet à l’utilisateur de partager ses données ou ses animaux (QR, export).
// Doit être visuellement clair, responsive et conforme au brandbook.
// Préparé pour afficher un QR code, un bouton d’export, et d’autres options IA.
library;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Partage")),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            "Partage rapide",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF183153),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFD6D6D6)),
            ),
            alignment: Alignment.center,
            child: const Text("🔲 QR Code ici"),
          ),
          const SizedBox(height: 32),
          const Text(
            "Exporter mes données",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF183153),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () async {
              final auth = Provider.of<UserProvider>(context, listen: false).authService;
              if (!await auth.verifyBiometric()) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vérification biométrique échouée')),
                );
                return;
              }
              if (!context.mounted) return;
              // Action d'export future
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Export IA à venir"),
              ));
            },
            icon: const Icon(Icons.upload_file),
            label: const Text("Exporter mes données"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF183153),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

