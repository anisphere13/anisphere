/// Copilot Prompt : HomeScreen AniSphère enrichi avec IA.
/// Intègre les widgets IA dynamiques : IABanner, IAChip, IASuggestionCard, IALogViewer.
/// Affiche les résumés IA des modules actifs via ModulesSummaryService.

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

import '../services/modules_summary_service.dart';
import '../services/animal_service.dart';
import '../providers/ia_context_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> iaActions = [];
  bool iaReady = false;
  List<ModuleSummary> summaries = [];

  @override
  void initState() {
    super.initState();
    _initIA();
    _loadSummaries();
  }

  Future<void> _initIA() async {
    try {
      await IAMaster().initialize();

      final context =
          Provider.of<IAContextProvider>(context, listen: false).context;
      final actions = await IARuleEngine.analyzeAnimals([]);

      setState(() {
        iaActions = actions;
        iaReady = true;
      });
    } catch (e) {
      // Log uniquement en debug
      assert(() {
        debugPrint("❌ Erreur IA : $e");
        return true;
      }());
      setState(() {
        iaReady = true;
        iaActions = [];
      });
    }
  }

  Future<void> _loadSummaries() async {
    try {
      final contextIA =
          Provider.of<IAContextProvider>(context, listen: false).context;
      final summaryService = ModulesSummaryService(
        animalService: AnimalService(),
        context: contextIA,
      );
      final result = await summaryService.generateSummaries();
      if (mounted) {
        setState(() {
          summaries = result;
        });
      }
    } catch (e) {
      // Log uniquement en debug
      assert(() {
        debugPrint("❌ Erreur chargement résumés modules : $e");
        return true;
      }());
    }
  }

  /// 🧩 Génère dynamiquement les widgets des modules actifs
  List<Widget> _buildModuleSummaries() {
    return summaries
        .map((summary) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                leading: Text(
                  summary.icon,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(summary.moduleName),
                subtitle: Text(summary.summary),
                trailing: summary.isPremium
                    ? const Icon(Icons.star, color: Colors.amber)
                    : null,
              ),
            ))
        .toList();
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
                  key: ValueKey("ia-suggestion-$index"),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
