import '../models/identity_model.dart';
import '../models/genealogy_model.dart';

/// Holds computed statistics for an identity profile.
class IdentityStats {
  final double completeness;
  final int monthsSinceUpdate;

  const IdentityStats({
    required this.completeness,
    required this.monthsSinceUpdate,
  });
}

/// Service computing offline statistics about identity data.
class IdentityStatsService {
  IdentityStats compute({
    required IdentityModel identity,
    GenealogyModel? genealogy,
  }) {
    final totalFields = 4 + (genealogy != null ? 4 : 0);
    var filled = 0;
    if (identity.microchipNumber?.isNotEmpty == true) filled++;
    if (identity.photoUrl?.isNotEmpty == true) filled++;
    if (identity.status?.isNotEmpty == true) filled++;
    if (identity.legalStatus?.isNotEmpty == true) filled++;

    if (genealogy != null) {
      if (genealogy.fatherName?.isNotEmpty == true) filled++;
      if (genealogy.motherName?.isNotEmpty == true) filled++;
      if (genealogy.affixe?.isNotEmpty == true) filled++;
      if (genealogy.litterNumber?.isNotEmpty == true) filled++;
    }

    final completeness =
        totalFields > 0 ? (filled / totalFields) * 100 : 0.0;
    final months =
        DateTime.now().difference(identity.lastUpdate).inDays ~/ 30;
    return IdentityStats(
      completeness: double.parse(completeness.toStringAsFixed(1)),
      monthsSinceUpdate: months,
    );
  }
}
