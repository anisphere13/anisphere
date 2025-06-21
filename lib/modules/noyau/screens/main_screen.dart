// Copilot Prompt : MainScreen avec navigation sécurisée et IAScheduler.
// Comporte 4 onglets dynamiques.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme.dart';
import 'home_screen.dart';
import 'share_screen.dart';
import 'modules_screen.dart';
import 'animals_screen.dart';
import 'notifications_screen.dart';
import 'qr_screen.dart';

import 'package:anisphere/modules/noyau/widgets/more_menu.dart';

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
  late final NotificationService _notificationService;
  late final List<Widget> _pages;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationService = NotificationService();
    _pages = [
      HomeScreen(notificationService: _notificationService),
      const ShareScreen(),
      const ModulesScreen(),
      const AnimalsScreen(),
    ];
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
          notificationService: _notificationService,
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
        title: const Text(
          'Maison',
          style: TextStyle( // Codex: Correction automatique flutter analyze
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: primaryBlue,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code, color: primaryBlue),
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
          const MoreMenuButton(),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Maison',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.share),
            label: 'Partage',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.apps),
            label: 'Modules',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.pets),
            label: 'Mes Animaux',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
