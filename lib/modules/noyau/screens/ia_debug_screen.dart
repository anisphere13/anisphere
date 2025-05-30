/// Écran caché de debug IA — réservé à super_admin
/// Accès masqué dans l’app, destiné à la maintenance technique IA
/// Affiche logs, flags, stats IA internes.

library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/local_storage_service.dart';
import '../logic/ia_logger.dart';
import '../logic/ia_master.dart';
import '../providers/user_provider.dart';

class IADebugScreen extends StatefulWidget {
  const IADebugScreen({super.key});

  @override
  State<IADebugScreen> createState() => _IADebugScreenState();
}

class _IADebugScreenState extends State<IADebugScreen> {
  List<String> logs = [];
  String? lastSync;
  String uxMode = "unknown";

  @override
  void initState() {
    super.initState();
    _loadDebugData();
  }

  Future<void> _loadDebugData() async {
    try {
      final iaLogs = IALogger.getLogs();
      final lastSyncDate =
          LocalStorageService.get("last_ia_sync", defaultValue: "Jamais");
      // Simule un contexte minimal pour la décision IA
      uxMode = IAMaster.instance.decideUXMode(
        isFirstLaunch: false,
        isOffline: false,
        hasAnimals: true,
      );
      if (mounted) {
        setState(() {
          logs = iaLogs.reversed.toList();
          lastSync = lastSyncDate;
        });
      }
    } catch (e) {
      // Log uniquement en debug
      assert(() {
        debugPrint("❌ Erreur chargement debug IA : $e");
        return true;
      }());
      if (mounted) {
        setState(() {
          logs = [];
          lastSync = "Erreur";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    if (user == null || user.role != 'super_admin') {
      return const Scaffold(
        body: Center(
          child: Text("Accès refusé : réservé au super_admin"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("🧠 Debug IA (super_admin)")),
      body: RefreshIndicator(
        onRefresh: _loadDebugData,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text("🔁 Dernière sync cloud : $lastSync"),
            const SizedBox(height: 8),
            Text("📱 UX IA actuelle : $uxMode"),
            const SizedBox(height: 16),
            const Text(
              "🧠 Logs IA",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...logs.map((log) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(log, style: const TextStyle(fontSize: 12)),
                )),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  await IALogger.clearLogs();
                  await _loadDebugData();
                } catch (e) {
                  // Log uniquement en debug
                  assert(() {
                    debugPrint("❌ Erreur suppression logs IA : $e");
                    return true;
                  }());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text("Erreur lors de la suppression des logs IA.")),
                  );
                }
              },
              icon: const Icon(Icons.delete_forever),
              label: const Text("Vider les logs IA"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade300),
            )
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';