// Copilot Prompt : MainScreen avec navigation sécurisée et IAScheduler.
// Comporte 4 onglets dynamiques.
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/i18n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'share_screen.dart';
import 'modules_screen.dart';
import 'animals_screen.dart';
import 'settings_screen.dart';
import 'user_profile_screen.dart';
import 'notifications_screen.dart';
import 'qr_screen.dart';
import 'support_screen.dart';

import 'package:anisphere/modules/noyau/widgets/notification_icon.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/logic/ia_scheduler.dart';
import 'package:anisphere/modules/noyau/logic/ia_executor.dart';
import 'package:anisphere/modules/noyau/services/animal_service.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';
import 'package:anisphere/modules/noyau/logic/ia_master.dart';
import 'package:anisphere/modules/noyau/services/notification_service.dart';
import 'package:anisphere/modules/noyau/providers/ia_context_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  IAScheduler? _scheduler;
  static final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const ShareScreen(),
    const ModulesScreen(),
    const AnimalsScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // ⚙️ Planification IA dès que le widget est monté
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = Provider.of<UserProvider>(context, listen: false).user;
      final contextIA = Provider.of<IAContextProvider>(
        context,
        listen: false,
      ).context;
      if (user != null) {
        final executor = IAExecutor(
          iaMaster: IAMaster.instance,
          notificationService: NotificationService(),
          modulesService: ModulesService(),
          animalService: AnimalService(),
        );
        _scheduler = IAScheduler(
          executor: executor,
          iaMaster: IAMaster.instance,
          user: user,
        );
        _scheduler!.start(contextIA);
      }
    });
  }

  @override
  void dispose() {
    _scheduler?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)?.mainScreenTitle ?? 'Home',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFF183153),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code, color: Color(0xFF183153)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QRScreen()),
              );
            },
          ),
          NotificationIcon(
            unreadCount: 3, // 🔜 à connecter au provider de notifications
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Color(0xFF183153)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserProfileScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF183153)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.help_outline, color: Color(0xFF183153)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SupportScreen()),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)?.home_title ?? 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.share),
            label: AppLocalizations.of(context)?.share_title ?? 'Partage',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.apps),
            label: AppLocalizations.of(context)?.modules_title ?? 'Modules',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.pets),
            label: AppLocalizations.of(context)?.myAnimals_title ?? 'Mes Animaux',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
