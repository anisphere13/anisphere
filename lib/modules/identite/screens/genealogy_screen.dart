import 'package:flutter/material.dart';
import 'package:anisphere/l10n/app_localizations.dart';

class GenealogyScreen extends StatelessWidget {
  const GenealogyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.genealogy_title)),
      body: const Center(
        child: Text('Arbre généalogique en préparation'),
      ),
    );
  }
}
