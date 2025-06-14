// TODO: ajouter test
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/consent_provider.dart';
import '../providers/user_provider.dart';

class LegalScreen extends StatefulWidget {
  const LegalScreen({super.key});

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  Future<void> _accept() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user == null) return;
    await Provider.of<ConsentProvider>(context, listen: false)
        .addAction(ConsentAction.accepted, user.id);
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  Future<void> _decline() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user == null) return;
    await Provider.of<ConsentProvider>(context, listen: false)
        .addAction(ConsentAction.declined, user.id);
    if (!mounted) return;
    Navigator.of(context).pop(false);
  }

  Future<void> _requestExport() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user == null) return;
    await Provider.of<ConsentProvider>(context, listen: false)
        .addAction(ConsentAction.exportRequested, user.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Demande d\'export envoy\u00e9e.')),
    );
  }

  Future<void> _requestDeletion() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user == null) return;
    await Provider.of<ConsentProvider>(context, listen: false)
        .addAction(ConsentAction.deletionRequested, user.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Demande de suppression envoy\u00e9e.')),
    );
  }

  void _showHistory() {
    final history =
        Provider.of<ConsentProvider>(context, listen: false).history;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Historique des consentements'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: history.length,
            itemBuilder: (_, i) {
              final entry = history[i];
              return ListTile(
                title: Text(entry.action.name),
                subtitle: Text(entry.timestamp.toLocal().toString()),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CGU & Confidentialit\u00e9')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Conditions g\u00e9n\u00e9rales d\'utilisation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Voici les derni\u00e8res CGU...'),
            const SizedBox(height: 24),
            const Text(
              'Politique de confidentialit\u00e9',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Voici la politique de confidentialit\u00e9...'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _accept,
              child: const Text('Accepter'),
            ),
            ElevatedButton(
              onPressed: _decline,
              child: const Text('Refuser'),
            ),
            const Divider(height: 32),
            ElevatedButton(
              onPressed: _showHistory,
              child: const Text('Voir l\'historique des consentements'),
            ),
            ElevatedButton(
              onPressed: _requestExport,
              child: const Text('Demander l\'export de mes donn\u00e9es'),
            ),
            ElevatedButton(
              onPressed: _requestDeletion,
              child: const Text('Demander la suppression de mes donn\u00e9es'),
            ),
          ],
        ),
      ),
    );
  }
}
