// Copilot Prompt : Écran de partage AniSphère.
// Permet à l’utilisateur de partager ses données ou ses animaux (QR, export).
// Doit être visuellement clair, responsive et conforme au brandbook.
// Préparé pour afficher un QR code, un bouton d’export, et d’autres options IA.

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anisphere/modules/noyau/i18n/app_localizations.dart';
import '../providers/user_provider.dart';
import '../models/share_history_model.dart';
import '../services/local_sharing_service.dart';
import '../services/cloud_sharing_service.dart';
import '../services/share_history_service.dart';
import '../services/navigation_service.dart';
import 'iap_screen.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  final ShareHistoryService _historyService = ShareHistoryService();
  late Future<List<ShareHistoryModel>> _historyFuture;
  late Future<List<ConnectivityResult>> _connectivityFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = _historyService.getEntries();
    _connectivityFuture = Connectivity().checkConnectivity();
  }

  Future<void> _refreshHistory() async {
    final entries = await _historyService.getEntries();
    setState(() {
      _historyFuture = Future.value(entries);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final isPremium = user?.iaPremium ?? false;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          FutureBuilder<List<ConnectivityResult>>(
            future: _connectivityFuture,
            builder: (context, snapshot) {
              final status = snapshot.hasData &&
                      !snapshot.data!.contains(ConnectivityResult.none)
                  ? 'En ligne'
                  : 'Hors ligne';
              return Text('Statut connexion : $status');
            },
          ),
          if (!isPremium) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Partage cloud réservé aux comptes premium',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                NavigationService.push(const IAPScreen());
              },
              child: const Text('Passer Premium'),
            ),
          ],
          const Divider(),
          ElevatedButton(
              onPressed: () async {
                await LocalSharingService().share('default');
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(AppLocalizations.of(context)!
                          .local_share_success)),
                );
                await _refreshHistory();
              },
            child: const Text('Partager localement'),
          ),
          ElevatedButton(
            onPressed: isPremium
                ? () async {
                    await CloudSharingService().share('default');
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .cloud_share_success)),
                    );
                    await _refreshHistory();
                  }
                : null,
            child: const Text('Partager via le cloud'),
          ),
          const SizedBox(height: 24),
          const Text(
            'Partages précédents',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          FutureBuilder<List<ShareHistoryModel>>(
            future: _historyFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              }
              final history = snapshot.data!;
              if (history.isEmpty) {
                return const Text('Aucun partage enregistré.');
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final h = history[index];
                  return ListTile(
                    title: Text('${h.mode} - ${h.date.toLocal()}'),
                    subtitle: Text(h.success ? 'Succès' : 'Échec'),
                    trailing: h.cost > 0
                        ? Text('${h.cost.toStringAsFixed(2)}€')
                        : null,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

