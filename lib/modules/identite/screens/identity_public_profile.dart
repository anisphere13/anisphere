import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/i18n/app_localizations.dart';
import '../models/identity_model.dart';
import '../models/genealogy_model.dart';
import '../widgets/identity_summary_widget.dart';
import '../widgets/genealogy_summary_card.dart';

/// Public profile screen used when displaying the QR code page.
class IdentityPublicProfile extends StatelessWidget {
  final IdentityModel identity;
  final GenealogyModel? genealogy;
  const IdentityPublicProfile({
    super.key,
    required this.identity,
    this.genealogy,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.identity_public_profile_title)),
      body: ListView(
        children: [
          IdentitySummaryWidget(identity: identity),
          if (genealogy != null) GenealogySummaryCard(genealogy: genealogy!),
        ],
      ),
    );
  }
}
