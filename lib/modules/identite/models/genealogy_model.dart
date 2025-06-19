import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'genealogy_model.g.dart';

/// Hive model storing genealogy information for an animal.
/// Includes parents IDs, breeder affix, litter number and LOF name.
@HiveType(typeId: 42)
class GenealogyModel {
  @HiveField(0)
  final String animalId;

  @HiveField(1)
  final String? fatherId;

  @HiveField(2)
  final String? motherId;

  @HiveField(3)
  final String? affixe;

  @HiveField(4)
  final String? litterNumber;

  @HiveField(5)
  final String? lofName;

  @HiveField(6)
  final DateTime lastUpdate;

  GenealogyModel({
    required this.animalId,
    this.fatherId,
    this.motherId,
    this.affixe,
    this.litterNumber,
    this.lofName,
    DateTime? lastUpdate,
  }) : lastUpdate = lastUpdate ?? DateTime.now();

  factory GenealogyModel.fromMap(Map<String, dynamic> map) {
    return GenealogyModel(
      animalId: map['animalId'] ?? '',
      fatherId: map['fatherId'],
      motherId: map['motherId'],
      affixe: map['affixe'],
      litterNumber: map['litterNumber'],
      lofName: map['lofName'],
      lastUpdate: (map['lastUpdate'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'animalId': animalId,
      'fatherId': fatherId,
      'motherId': motherId,
      'affixe': affixe,
      'litterNumber': litterNumber,
      'lofName': lofName,
      'lastUpdate': Timestamp.fromDate(lastUpdate),
    };
  }
}
