// Copilot Prompt : MainScreen avec navigation sécurisée et IAScheduler.
// Comporte 4 onglets dynamiques.
import 'package:flutter/material.dart';
import 'package:anisphere/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'share_screen.dart';
import 'modules_screen.dart';
import 'animals_screen.dart';
import 'settings_screen.dart';
import 'user_profile_screen.dart';
import 'login_screen.dart';
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
  void _handleMenuSelection(String value) {
    switch (value) {
      case 'profile':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const UserProfileScreen()),
        );
        break;
      case 'settings':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SettingsScreen()),
        );
        break;
      case 'support':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SupportScreen()),
        );
        break;
      case 'logout':
        Provider.of<UserProvider>(context, listen: false).signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
        break;
    }
  }
  @override
  void initState() {
    super.initState();
    // ⚙️ Planification IA dès que le widget est monté
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = Provider.of<UserProvider>(context, listen: false).user;
      final contextIA = Provider.of<IAContextProvider>(context, listen: false).context;
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
        backgroundColor: const Color(0xFFF5F5F5),
        foregroundColor: const Color(0xFF183153),
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.mainScreenTitle,
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
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xFF183153)),
            onSelected: _handleMenuSelection,
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'profile', child: Text('Mon Profil')),
              PopupMenuItem(value: 'settings', child: Text('Paramètres')),
              PopupMenuItem(value: 'support', child: Text('Support')),
              PopupMenuItem(value: 'logout', child: Text('Se déconnecter')),
            ],
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.share), label: 'Partage'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Modules'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Mes Animaux'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
