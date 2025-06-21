// TODO: ajouter test
// Copilot Prompt : écran GPS pour AniSphère.
// Affiche les traces enregistrées sur une carte interne
// avec options pour la synchronisation et les logs IA.

import 'package:flutter/material.dart';

import '../services/local_storage_service.dart';
import '../widgets/ia_log_viewer.dart';
import 'package:anisphere/theme.dart';

class GpsScreen extends StatefulWidget {
  const GpsScreen({super.key});

  @override
  State<GpsScreen> createState() => _GpsScreenState();
}

class _GpsScreenState extends State<GpsScreen> {
  bool syncEnabled = false;
  bool showLogs = false;
  List<List<double>> traces = [];

  @override
  void initState() {
    super.initState();
    _loadPrefs();
    _loadTraces();
  }

  void _loadPrefs() {
    syncEnabled = LocalStorageService.get('gps_sync', defaultValue: false);
    showLogs = LocalStorageService.get('gps_logs', defaultValue: false);
  }

  void _savePrefs() {
    LocalStorageService.set('gps_sync', syncEnabled);
    LocalStorageService.set('gps_logs', showLogs);
  }

  void _loadTraces() {
    final stored = LocalStorageService.get('gps_traces', defaultValue: <List<dynamic>>[]);
    traces = (stored as List).map((e) => (e as List).cast<double>()).toList();
  }

  Widget _buildMap() {
    if (traces.isEmpty) {
      return const Center(child: Text('Aucune trace enregistrée.'));
    }
    return Container(
      color: backgroundGray,
      alignment: Alignment.center,
      child: const Text('Carte interne (placeholder)'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Traces GPS')),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Synchronisation active'),
            value: syncEnabled,
            onChanged: (v) => setState(() {
              syncEnabled = v;
              _savePrefs();
            }),
          ),
          SwitchListTile(
            title: const Text('Afficher les logs analyse'),
            value: showLogs,
            onChanged: (v) => setState(() {
              showLogs = v;
              _savePrefs();
            }),
          ),
          Expanded(child: _buildMap()),
          if (showLogs)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: IALogViewer(),
            ),
        ],
      ),
    );
  }
}
