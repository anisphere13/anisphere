import 'package:hive/hive.dart';

part 'genealogy_model.g.dart';

/// Simple model representing animal genealogy relations.
@HiveType(typeId: 42)
class GenealogyModel {
  @HiveField(0)
  final String animalId;

  @HiveField(1)
  final String? fatherName;

  @HiveField(2)
  final String? motherName;

  @HiveField(3)
  final String? affixe;

  @HiveField(4)
  final String? litterNumber;

  @HiveField(5)
  final String? lofName;

  @HiveField(6)
  final DateTime lastUpdate;

  @HiveField(7)
  final String? originCountry;

  const GenealogyModel({
    required this.animalId,
    this.fatherName,
    this.motherName,
    this.affixe,
    this.litterNumber,
    this.lofName,
    this.originCountry,
    DateTime? lastUpdate,
  }) : lastUpdate = lastUpdate ?? DateTime.now();

  factory GenealogyModel.fromMap(Map<String, dynamic> map) {
    return GenealogyModel(
      animalId: map['animalId'] ?? '',
      fatherName: map['fatherName'] ?? map['fatherId'],
      motherName: map['motherName'] ?? map['motherId'],
      affixe: map['affixe'],
      litterNumber: map['litterNumber'],
      lofName: map['lofName'],
      originCountry: map['originCountry'],
      lastUpdate: map['lastUpdate'] is DateTime
          ? map['lastUpdate'] as DateTime
          : DateTime.tryParse(map['lastUpdate'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'animalId': animalId,
      'fatherName': fatherName,
      'motherName': motherName,
      'affixe': affixe,
      'litterNumber': litterNumber,
      'lofName': lofName,
      'originCountry': originCountry,
      'lastUpdate': lastUpdate.toIso8601String(),
    };
  }
}
