// Écran complet des paramètres AniSphère avec sauvegarde

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme.dart';
import '../services/local_storage_service.dart';
import '../services/backup_service.dart';
import '../providers/user_provider.dart';
import '../services/animal_service.dart';
import '../providers/theme_provider.dart';
import 'feedback_settings_screen.dart';
import '../providers/payment_provider.dart';
import 'iap_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool iaSuggestions = true;
  bool iaNotifications = true;
  DateTime? lastBackup;

  late BackupService backupService;

  @override
  void initState() {
    super.initState();
    backupService = BackupService(
      userService: Provider.of<UserProvider>(context, listen: false).userService,
      animalService: AnimalService(),
    );
    _loadPreferences();
    _loadLastBackup();
  }

  Future<void> _loadPreferences() async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    await themeProvider.load();
    setState(() {
      darkMode = themeProvider.isDarkMode;
      iaSuggestions = LocalStorageService.get("ia_suggestions", defaultValue: true);
      iaNotifications = LocalStorageService.get("ia_notifications", defaultValue: true);
    });
  }

  Future<void> _updatePreference(String key, dynamic value) async {
    if (key == "dark_mode") {
      await Provider.of<ThemeProvider>(context, listen: false).setDarkMode(value);
    } else {
      await LocalStorageService.set(key, value);
    }
    await _loadPreferences();
  }


  Future<void> _performBackup() async {
    final messenger = ScaffoldMessenger.of(context);
    final success = await backupService.performBackup();
    if (success) {
      await _loadLastBackup();
      messenger.showSnackBar(
        const SnackBar(content: Text('Sauvegarde effectuée avec succès.')),
      );
    } else {
      messenger.showSnackBar(
        const SnackBar(content: Text('Erreur lors de la sauvegarde.')),
      );
    }
  }

  Future<void> _restoreBackup() async {
    final messenger = ScaffoldMessenger.of(context);
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user == null) return;

    final success = await backupService.restoreBackup(user.id);
    if (success) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Restauration réussie.')),
      );
    } else {
      messenger.showSnackBar(
        const SnackBar(content: Text('Erreur lors de la restauration.')),
      );
    }
  }

  Future<void> _loadLastBackup() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      final date = await backupService.getLastBackupDate(user.id);
      setState(() => lastBackup = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text("Préférences générales", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text("Mode sombre"),
            subtitle: const Text("Thème sombre automatique"),
            value: darkMode,
            onChanged: (val) => _updatePreference("dark_mode", val),
          ),
          const Divider(),
          const Text("Intelligence Artificielle", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
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
          ListTile(
            leading: const Icon(Icons.vibration, color: primaryBlue),
            title: const Text('Feedback audio/haptique'),
            subtitle: const Text('Configurer les sons et vibrations'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const FeedbackSettingsScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.workspace_premium, color: primaryBlue),
            title: const Text('Passer Premium'),
            subtitle: const Text('Débloquez toutes les fonctionnalités'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              final paymentProvider =
                  Provider.of<PaymentProvider>(context, listen: false);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider.value(
                    value: paymentProvider,
                    child: const IAPScreen(),
                  ),
                ),
              );
            },
          ),
          const Divider(),
          const Text("Sauvegarde & restauration", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.backup, color: primaryBlue),
            title: const Text("Effectuer une sauvegarde"),
            subtitle: Text(lastBackup != null ? "Dernière : ${lastBackup!.toLocal()}" : "Aucune sauvegarde"),
            onTap: _performBackup,
          ),
          ListTile(
            leading: const Icon(Icons.restore, color: primaryBlue),
            title: const Text("Restaurer une sauvegarde"),
            subtitle: const Text("Restaurez vos données depuis le cloud."),
            onTap: _restoreBackup,
          ),
        ],
      ),
    );
  }
}
