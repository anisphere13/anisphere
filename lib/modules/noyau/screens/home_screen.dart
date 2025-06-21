// Copilot Prompt : HomeScreen AniSphère enrichi avec IA.
// Intègre les widgets IA dynamiques : IABanner, IAChip, IASuggestionCard, IALogViewer.
// Affiche les résumés IA des modules actifs via ModulesSummaryService.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme.dart';

import '../services/modules_summary_service.dart';
import '../services/animal_service.dart';
import '../providers/ia_context_provider.dart';
import '../providers/user_provider.dart';
import '../services/pro_validation_service.dart';
import '../widgets/quick_actions_sheet.dart';
import '../widgets/user_profile_summary_card.dart';
import '../widgets/important_notifications_widget.dart';
import '../services/notification_service.dart';
import 'animal_form_screen.dart';

class HomeScreen extends StatefulWidget {
  final NotificationService notificationService;

  const HomeScreen({super.key, required this.notificationService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ModuleSummary> summaries = [];
  bool loadingSummaries = true;
  bool proValidated = true;
  List<String> importantNotifications = [];

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => QuickActionsSheet(
        onAddAnimal: () async {
          Navigator.pop(context);
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AnimalFormScreen()),
          );
          _loadSummaries();
        },
        onAddHealthNote: () {},
        onAddPhoto: () {},
        onAddActivity: () {},
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadSummaries();
    _loadProfile();
    _loadImportantNotifications();
  }

  Future<void> _loadProfile() async {
    final service = ProValidationService();
    final profile = await service.getProfile();
    if (mounted) {
      setState(() {
        proValidated = profile?.proValidated ?? false;
      });
    }
  }

  Future<void> _loadSummaries() async {
    setState(() => loadingSummaries = true);
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
      debugPrint("❌ Erreur chargement résumés modules : $e");
      setState(() => loadingSummaries = false);
    }
  }

  Future<void> _loadImportantNotifications() async {
    try {
      final pending = await widget.notificationService.fetchPendingNotifications();
      if (mounted) {
        setState(() {
          importantNotifications = pending;
        });
      }
    } catch (e) {
      debugPrint('❌ Erreur chargement notifications : $e');
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
            ? const Icon(Icons.star, color: primaryBlue)
            : const SizedBox.shrink(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        child: loadingSummaries
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
                      if (user != null)
                        SliverToBoxAdapter(
                          child: UserProfileSummaryCard(
                            user: user,
                            proValidated: proValidated,
                          ),
                        ),
                      if (importantNotifications.isNotEmpty)
                        SliverToBoxAdapter(
                          child: ImportantNotificationsWidget(
                            notifications: importantNotifications,
                          ),
                        ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "Résumé des modules actifs",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryBlue,
        onPressed: _showQuickActions,
        child: const Icon(Icons.add),
      ),
    );
  }
}
