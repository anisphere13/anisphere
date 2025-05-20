/// Copilot Prompt : HomeScreen AniSphère enrichi avec IA.
/// Intègre les widgets IA dynamiques : IABanner, IAChip, IASuggestionCard, IALogViewer.
/// Récupère des actions IA depuis IAMaster / RuleEngine et les affiche.
library;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../screens/login_screen.dart';

import '../logic/ia_master.dart';
import '../logic/ia_rule_engine.dart';
import '../logic/ia_context.dart';
import '../widgets/ia_banner.dart';
import '../widgets/ia_chip.dart';
import '../widgets/ia_suggestion_card.dart';
import '../widgets/ia_log_viewer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> iaActions = [];
  bool iaReady = false;

  @override
  void initState() {
    super.initState();
    _initIA();
  }

  Future<void> _initIA() async {
    await IAMaster().initialize();

    // Contexte simulé (en prod, on utiliserait un vrai User/AnimalProvider)
    final context = IAContext(
      isOffline: false,
      isFirstLaunch: false,
      hasAnimals: true,
      animalCount: 2,
    );

    final actions = await IARuleEngine.analyzeAnimals([]);
    setState(() {
      iaActions = actions;
      iaReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                userProvider.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
            itemBuilder: (BuildContext context) => const [
              PopupMenuItem(value: 'logout', child: Text('Se Déconnecter')),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IABanner(
            message: "Mode IA : Local uniquement (démo)",
            icon: Icons.lightbulb_outline,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: IAChip(label: "UX adaptative"),
          ),
          if (iaReady && iaActions.isNotEmpty)
            ...iaActions.map(
              (action) => IASuggestionCard(
                title: "Suggestion IA",
                message: "Action détectée : $action",
                icon: Icons.auto_awesome,
              ),
            ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: IALogViewer(),
          ),
        ],
      ),
    );
  }
}
