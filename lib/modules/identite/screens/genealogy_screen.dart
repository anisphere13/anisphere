import 'package:flutter/material.dart';
import 'package:anisphere/l10n/app_localizations.dart';

class GenealogyScreen extends StatelessWidget {
  const GenealogyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(t.genealogy_title)),
      body: Center(child: Text(t.genealogy_screen_text)),
    );
  }
}
