/// Copilot Prompt : Écran des paramètres AniSphère.
/// Permet à l’utilisateur de configurer les préférences de l’app.
/// Options actuelles : dark mode, notifications IA, suggestions IA.
/// Préférences stockées avec LocalStorageService.
library;
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/services/local_storage_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool iaSuggestions = true;
  bool iaNotifications = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    setState(() {
      darkMode = LocalStorageService.get("dark_mode", defaultValue: false);
      iaSuggestions = LocalStorageService.get("ia_suggestions", defaultValue: true);
      iaNotifications = LocalStorageService.get("ia_notifications", defaultValue: true);
    });
  }

  Future<void> _updatePreference(String key, dynamic value) async {
    await LocalStorageService.set(key, value);
    await _loadPreferences();
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
              color: Color(0xFF183153),
            ),
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
            "Intelligence artificielle",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF183153),
            ),
          ),
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
        ],
      ),
    );
  }
}
