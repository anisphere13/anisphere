/// Écran des paramètres AniSphère (IA + préférences + admin hidden tools)
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/local_storage_service.dart';
import '../services/ia_log_service.dart';
import '../services/modules_service.dart';
import '../providers/user_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool iaSuggestions = true;
  bool iaNotifications = true;
  bool isSuperAdmin = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    setState(() {
      darkMode = LocalStorageService.get("dark_mode", defaultValue: false);
      iaSuggestions =
          LocalStorageService.get("ia_suggestions", defaultValue: true);
      iaNotifications =
          LocalStorageService.get("ia_notifications", defaultValue: true);
      isSuperAdmin = user?.role == 'super_admin';
    });
  }

  Future<void> _updatePreference(String key, dynamic value) async {
    await LocalStorageService.set(key, value);
    await _loadPreferences();
  }

  Future<void> _resetIA() async {
    await LocalStorageService.set("firstLaunch", true);
    await ModulesService.resetAllStatuses();
    await IALogService.clearLogs();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("IA réinitialisée avec succès.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paramètres")),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            "Préférences générales",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF183153)),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text("Mode sombre"),
            subtitle: const Text("Thème sombre automatique"),
            value: darkMode,
            onChanged: (val) => _updatePreference("dark_mode", val),
          ),
          const Divider(),
          const Text(
            "Intelligence Artificielle",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF183153)),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text("Suggestions IA"),
            subtitle: const Text("Activer les recommandations personnalisées"),
            value: iaSuggestions,
            onChanged: (val) => _updatePreference("ia_suggestions", val),
          ),
          SwitchListTile(
            title: const Text("Notifications IA"),
            subtitle: const Text("Recevoir des alertes intelligentes"),
            value: iaNotifications,
            onChanged: (val) => _updatePreference("ia_notifications", val),
          ),
          if (isSuperAdmin) ...[
            const Divider(),
            const Text(
              "Maintenance IA (super admin uniquement)",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.delete_forever),
              label: const Text("Effacer tous les logs IA"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
              ),
              onPressed: () async {
                try {
                  await IALogService.clearLogs();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Logs IA supprimés")),
                  );
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
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.restart_alt),
              label: const Text("Réinitialiser l'IA locale"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
              onPressed: _resetIA,
            ),
          ]
        ],
      ),
    );
  }
}
