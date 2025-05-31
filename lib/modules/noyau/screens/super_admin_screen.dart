/// Copilot Prompt : SuperAdminScreen sécurisé pour AniSphère.
/// Réservé au rôle "superadmin". Affiche les logs IA, flags, statut sync, et actions debug IA.
/// Écran masqué, accessible uniquement en mode développeur ou via menu caché.
/// Permet de surveiller et gérer l’IA maîtresse à distance.

library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../logic/ia_logger.dart';
import '../logic/ia_flag.dart';
import '../logic/ia_master.dart';

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
          ? "${syncDate.day}/${syncDate.month}/${syncDate.year} ${syncDate.hour}h${syncDate.minute.toString().padLeft(2, '0')}"
          : "Jamais synchronisé";
    });
  }

  Future<void> _clearLogs() async {
    await IALogger.clearLogs();
    await _loadData();
  }

  Future<void> _forceSync() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      await IAMaster.instance.syncCloudIA(user.id);
      await _loadData();
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
          Text("🕒 Dernière synchronisation : $lastSync"),
          const SizedBox(height: 16),
          const Text("🔖 Flags IA actifs :",
              style: TextStyle(fontWeight: FontWeight.bold)),
          ...flags.entries.map((e) => ListTile(
                title: Text(e.key),
                trailing: Icon(
                  e.value ? Icons.check_circle : Icons.cancel,
                  color: e.value ? Colors.green : Colors.red,
                ),
              )),
          const Divider(),
          const Text("🧠 Logs IA :",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...logs.map((log) => Text(log)).toList(),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.cleaning_services),
            label: const Text("Vider les logs"),
            onPressed: _clearLogs,
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            icon: const Icon(Icons.cloud_sync),
            label: const Text("Forcer une synchronisation IA"),
            onPressed: _forceSync,
          ),
        ],
      ),
    );
  }
}
