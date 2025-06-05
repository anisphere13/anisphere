// Copilot Prompt : SuperAdminScreen sécurisé pour AniSphère.
// Réservé au rôle "superadmin". Affiche logs IA, flags, statut sync, et permet de forcer une synchronisation.
// Écran masqué, accessible uniquement en mode développeur ou via menu caché.
// Optimisé UI et sécurité. UX fluide, statut clair.
library;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../logic/ia_logger.dart';
import '../logic/ia_flag.dart';
import '../logic/ia_master.dart';
import 'support_admin_screen.dart';

class SuperAdminScreen extends StatefulWidget {
  const SuperAdminScreen({super.key});
  @override
  State<SuperAdminScreen> createState() => _SuperAdminScreenState();
}
class _SuperAdminScreenState extends State<SuperAdminScreen> {
  List<String> logs = [];
  Map<String, bool> flags = {};
  String lastSync = "Non disponible";
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  Future<void> _loadData() async {
    final fetchedLogs = IALogger.getLogs();
    final fetchedFlags = IAFlag.getAll();
    final syncDate = IAMaster.instance.getLastSyncDate();
    setState(() {
      logs = fetchedLogs.reversed.toList();
      flags = fetchedFlags;
      lastSync = syncDate != null
          ? "${syncDate.day}/${syncDate.month}/${syncDate.year} à ${syncDate.hour}h${syncDate.minute.toString().padLeft(2, '0')}"
          : "Jamais synchronisé";
    });
  }
  Future<void> _clearLogs() async {
    final messenger = ScaffoldMessenger.of(context);
    await IALogger.clearLogs();
    await _loadData();
    if (!mounted) return;
    messenger.showSnackBar(
      const SnackBar(content: Text("Logs IA supprimés.")),
    );
  }

  Future<void> _forceSync() async {
    final messenger = ScaffoldMessenger.of(context);
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      await IAMaster.instance.syncCloudIA(user.id);
      await _loadData();
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text("Synchronisation IA lancée.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    if (user?.role != "superadmin") {
      return const Scaffold(
        body: Center(child: Text("🔒 Accès refusé")),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Super Admin — IA")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("🕒 Dernière synchronisation", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(lastSync),
          const SizedBox(height: 24),
          const Text("🔖 Flags IA actifs", style: TextStyle(fontWeight: FontWeight.bold)),
          ...flags.entries.map((e) => SwitchListTile(
                title: Text(e.key),
                value: e.value,
                onChanged: (_) {}, // readonly
                secondary: Icon(
                  e.value ? Icons.check_circle : Icons.cancel,
                  color: e.value ? Colors.green : Colors.red,
                ),
              )),
          const Divider(height: 32),
          const Text("🧠 Logs IA", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (logs.isEmpty)
            const Text("Aucun log IA enregistré pour l’instant."),
          ...logs.map((log) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text("- $log"),
              )),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.cleaning_services),
            label: const Text("Vider les logs"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade600),
            onPressed: _clearLogs,
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            icon: const Icon(Icons.cloud_sync),
            label: const Text("Forcer une synchronisation IA"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade700),
            onPressed: _forceSync,
          ),
          const SizedBox(height: 12),

          ElevatedButton.icon(
            icon: const Icon(Icons.support_agent),
            label: const Text('Voir les feedbacks'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SupportAdminScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
