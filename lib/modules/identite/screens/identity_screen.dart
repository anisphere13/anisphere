import 'package:flutter/material.dart';
import 'dart:io';

import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/noyau/providers/photo_provider.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import 'package:provider/provider.dart';
import '../services/identity_service.dart';
import '../models/identity_model.dart';
import '../widgets/identity_score_widget.dart';
import '../widgets/identity_breeder_section.dart';

/// Écran IdentityScreen pour AniSphère.
/// Affiche la fiche d'identité de l’animal (photo, puce, statut, QR),
/// permet la mise à jour manuelle et la génération de QR/page publique.

class IdentityScreen extends StatefulWidget {
  final List<AnimalModel> animals;
  final int initialIndex;
  final IdentityService service;

  const IdentityScreen({
    super.key,
    required this.animals,
    this.initialIndex = 0,
    required this.service,
  });

  @override
  State<IdentityScreen> createState() => _IdentityScreenState();
}

class _IdentityScreenState extends State<IdentityScreen> {
  late PageController _pageController;
  late int _currentIndex;
  IdentityModel? identity;
  bool loading = true;

  final microchipController = TextEditingController();
  final statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _checkOnboarding();
    _loadIdentity(widget.animals[_currentIndex]);
  }

  Future<void> _checkOnboarding() async {
    final done = await LocalStorageService.getBool('identity_onboarding_done');
    if (!done) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        const tConfirm = 'Confirmer';
        const onboardingMsg = "G\u00E9rez l'identit\u00E9 de votre animal ici. Glissez pour changer d'animal.";
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text(onboardingMsg),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(tConfirm),
              ),
            ],
          ),
        );
      });
      await LocalStorageService.set('identity_onboarding_done', true);
    }
  }

  Future<void> _loadIdentity(AnimalModel animal) async {
    final result = widget.service.getIdentityLocally(animal.id);
    setState(() {
      identity = result ?? IdentityModel(animalId: animal.id);
      microchipController.text = identity?.microchipNumber ?? '';
      statusController.text = identity?.status ?? '';
      loading = false;
    });
  }

  Future<void> _save() async {
    final updated = IdentityModel(
      animalId: widget.animals[_currentIndex].id,
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
      const SnackBar(content: Text('Identit\u00E9 mise \u00E0 jour')),
    );

    setState(() => identity = updated);
  }

  Future<void> _importICad() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Import I-CAD express...')),
    );
    final fetched =
        await widget.service.fetchFromFirestore(widget.animals[_currentIndex].id);
    if (fetched != null) {
      await widget.service.saveIdentityLocally(fetched);
      setState(() => identity = fetched);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());

    const badgeState = 'Badge';
    const confirm = 'Confirmer';
    const cancel = 'Annuler';
    const microchipLabel = 'Num\u00E9ro de puce';
    const statusLabel = 'Statut';
    const timelinePhotos = 'Photos chronologiques';

    return Scaffold(
      appBar: AppBar(title: const Text('Identit\u00E9')),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (i) {
          setState(() {
            loading = true;
            _currentIndex = i;
          });
          _loadIdentity(widget.animals[i]);
        },
        itemCount: widget.animals.length,
        itemBuilder: (context, index) {
          final animal = widget.animals[index];
          return loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(animal.name,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      IdentityScoreWidget(
                          score: identity?.verifiedByIA == true ? 100 : 50),
                      const SizedBox(height: 8),
                      Text('$badgeState: ${identity?.verifiedByIA == true ? confirm : cancel}'),
                      const SizedBox(height: 12),
                      IdentityBreederSection(
                          genealogy:
                              widget.service.getGenealogyLocally(animal.id)),
                      const SizedBox(height: 12),
                      TextField(
                        controller: microchipController,
                        decoration: const InputDecoration(labelText: microchipLabel),
                      ),
                      TextField(
                        controller: statusController,
                        decoration: const InputDecoration(labelText: statusLabel),
                      ),
                      const SizedBox(height: 8),
                      Text(timelinePhotos,
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 80,
                        child: Consumer<PhotoProvider>(
                          builder: (_, provider, __) {
                            final photos = provider.photos
                                .where((p) => p.animalId == animal.id)
                                .toList();
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: photos.length,
                              itemBuilder: (_, i) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Image.file(
                                  File(photos[i].localPath),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: _save, child: const Text('Enregistrer')),
                      const SizedBox(height: 8),
                      ElevatedButton(
                          onPressed: _importICad, child: const Text('Import I-CAD express')),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
