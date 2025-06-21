import 'package:flutter/material.dart';
import 'dart:io';

import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/noyau/providers/photo_provider.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import 'package:anisphere/l10n/app_localizations.dart';
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
        final t = AppLocalizations.of(context)!;
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text(t.identity_onboarding_message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(t.confirm),
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
      SnackBar(content: Text(AppLocalizations.of(context)!.identity_updated)),
    );

    setState(() => identity = updated);
  }

  Future<void> _importICad() async {
    final t = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${t.import_icad}...')),
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

    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(t.identity_screen_title)),
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
                      Text(
                          '${t.badge_state}: ${identity?.verifiedByIA == true ? t.confirm : t.cancel}'),
                      const SizedBox(height: 12),
                      IdentityBreederSection(
                          genealogy:
                              widget.service.getGenealogyLocally(animal.id)),
                      const SizedBox(height: 12),
                      TextField(
                        controller: microchipController,
                        decoration: InputDecoration(labelText: t.microchip_label),
                      ),
                      TextField(
                        controller: statusController,
                        decoration: InputDecoration(labelText: t.status_label),
                      ),
                      const SizedBox(height: 8),
                      Text(t.timeline_photos,
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
                          onPressed: _save, child: Text(t.save_button)),
                      const SizedBox(height: 8),
                      ElevatedButton(
                          onPressed: _importICad, child: Text(t.import_icad)),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
