import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';
import '../services/identity_service.dart';
import '../models/identity_model.dart';

/// Écran IdentityScreen pour AniSphère.
/// Affiche la fiche d'identité de l’animal (photo, puce, statut, QR),
/// permet la mise à jour manuelle et la génération de QR/page publique.

class IdentityScreen extends StatefulWidget {
  final AnimalModel animal;
  final IdentityService service;

  const IdentityScreen({
    super.key,
    required this.animal,
    required this.service,
  });

  @override
  State<IdentityScreen> createState() => _IdentityScreenState();
}

class _IdentityScreenState extends State<IdentityScreen> {
  IdentityModel? identity;
  bool loading = true;

  final microchipController = TextEditingController();
  final statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadIdentity();
  }

  Future<void> _loadIdentity() async {
    final result = widget.service.getIdentityLocally(widget.animal.id);
    setState(() {
      identity = result ?? IdentityModel(animalId: widget.animal.id);
      microchipController.text = identity?.microchipNumber ?? '';
      statusController.text = identity?.status ?? '';
      loading = false;
    });
  }

  Future<void> _save() async {
    final updated = IdentityModel(
      animalId: widget.animal.id,
      microchipNumber: microchipController.text,
      status: statusController.text,
      legalStatus: identity?.legalStatus,
      verifiedByIA: false,
      history: identity?.history ?? [],
    );
    final messenger = ScaffoldMessenger.of(context);
    await widget.service.saveIdentityLocally(updated);

    if (!mounted) return;

    messenger.showSnackBar(
      const SnackBar(content: Text("Identité mise à jour")),
    );

    setState(() => identity = updated);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(title: const Text("Identité de l’animal")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: microchipController,
              decoration: const InputDecoration(labelText: 'Numéro de puce'),
            ),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(labelText: 'Statut'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _save, child: const Text('Sauvegarder')),
          ],
        ),
      ),
    );
  }
}
