// Copilot Prompt : HomeScreen AniSphère enrichi avec IA.
// Intègre les widgets IA dynamiques : IABanner, IAChip, IASuggestionCard, IALogViewer.
// Affiche les résumés IA des modules actifs via ModulesSummaryService.

library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../screens/login_screen.dart';

import '../services/modules_summary_service.dart';
import '../services/animal_service.dart';
import '../providers/ia_context_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ModuleSummary> summaries = [];
  bool loadingSummaries = true;

  @override
  void initState() {
    super.initState();
    _loadSummaries();
  }

  Future<void> _loadSummaries() async {
    setState(() {
      loadingSummaries = true;
    });
    try {
      final iaContext =
          Provider.of<IAContextProvider>(context, listen: false).context;

      final summaryService = ModulesSummaryService(
        animalService: AnimalService(),
        context: iaContext,
      );

      final result = await summaryService.generateSummaries();

      if (mounted) {
        setState(() {
          summaries = result;
          loadingSummaries = false;
        });
      }
    } catch (e) {
      assert(() {
        debugPrint("❌ Erreur chargement résumés modules : $e");
        return true;
      }());
      setState(() {
        loadingSummaries = false;
      });
    }
  }

  Widget _buildModuleCard(ModuleSummary summary) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Text(
          summary.icon,
          style: const TextStyle(fontSize: 28),
        ),
        title: Text(
          summary.moduleName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(summary.summary),
        trailing: summary.isPremium
            ? const Icon(Icons.star, color: Colors.amber)
            : const SizedBox.shrink(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'logout') {
                final navigator = Navigator.of(context);
                await userProvider.signOut();
                if (mounted) {
                  navigator.pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                }
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'logout', child: Text('Se Déconnecter')),
            ],
          ),
        ],
      ),
      body: loadingSummaries
          ? const Center(child: CircularProgressIndicator())
          : summaries.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Aucun module actif.\nAjoutez ou activez des modules depuis l'onglet Modules.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Résumé des modules actifs",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF183153),
                              ),
                        ),
                      ),
                    ),
                    SliverList.builder(
                      itemCount: summaries.length,
                      itemBuilder: (context, index) =>
                          _buildModuleCard(summaries[index]),
                    ),
                  ],
                ),
    );
  }
}
