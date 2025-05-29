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

// 🔽 Import futurs widgets résumés de modules (ex : santé, dressage, éducation)
import '../../modules/sante/widgets/sante_summary_card.dart';
import '../../modules/dressage/widgets/dressage_summary_card.dart';
// ... ajoute d’autres ici selon les modules actifs

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

  /// 🧩 Génère dynamiquement les widgets des modules actifs
  List<Widget> _buildModuleSummaries() {
    final modules = Provider.of<UserProvider>(context, listen: false).user?.moduleRoles.keys ?? [];
    final List<Widget> widgets = [];

    if (modules.contains("sante")) {
      widgets.add(const SanteSummaryCard()); // résumé module Santé
    }
    if (modules.contains("dressage")) {
      widgets.add(const DressageSummaryCard()); // résumé module Dressage
    }
    // 🔽 Ajoute d’autres modules ici
    // if (modules.contains("education")) widgets.add(const EducationSummaryCard());

    return widgets;
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
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'logout', child: Text('Se Déconnecter')),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 📌 Widgets IA
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                IABanner(
                  message: "Mode IA : Local uniquement (démo)",
                  icon: Icons.lightbulb_outline,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: IAChip(label: "UX adaptative"),
                ),
              ],
            ),
          ),

          if (iaReady && iaActions.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: IASuggestionCard(
                    title: "Suggestion IA",
                    message: "Action détectée : ${iaActions[index]}",
                    icon: Icons.auto_awesome,
                  ),
                ),
                childCount: iaActions.length,
              ),
            ),

          // 🧠 Logs IA
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: IALogViewer(),
            ),
          ),

          // 🧩 Résumés des modules actifs
          SliverToBoxAdapter(
            child: Column(
              children: _buildModuleSummaries(),
            ),
          ),
        ],
      ),
    );
  }
}
