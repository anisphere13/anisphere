import 'package:flutter/material.dart';
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
import 'ia_debug_screen.dart'; // 👈 ajouté

import 'package:anisphere/modules/noyau/widgets/notification_icon.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

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
        Navigator.push(context, MaterialPageRoute(builder: (_) => const UserProfileScreen()));
        break;
      case 'settings':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
        break;
      case 'logout':
        Provider.of<UserProvider>(context, listen: false).signOut();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onLongPress: () {
            final user = Provider.of<UserProvider>(context, listen: false).user;
            if (user != null && user.role == 'super_admin') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const IADebugScreen()),
              );
            }
          },
          child: const Text('AniSphère'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QRScreen()),
              );
            },
          ),
          NotificationIcon(
            unreadCount: 3, // TODO: relier au provider
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuSelection,
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'profile', child: Text('Mon Profil')),
              PopupMenuItem(value: 'settings', child: Text('Paramètres')),
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
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
