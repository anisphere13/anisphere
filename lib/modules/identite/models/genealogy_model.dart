import 'package:hive/hive.dart';

part 'genealogy_model.g.dart';

/// Simple model representing animal genealogy relations.
@HiveType(typeId: 42)
class GenealogyModel {
  @HiveField(0)
  final String animalId;

  @HiveField(1)
  final String? fatherId;

  @HiveField(2)
  final String? motherId;

  @HiveField(3)
  final List<String> siblingsIds;

  const GenealogyModel({
    required this.animalId,
    this.fatherId,
    this.motherId,
    this.siblingsIds = const [],
  });

  factory GenealogyModel.fromMap(Map<String, dynamic> map) {
    return GenealogyModel(
      animalId: map['animalId'] ?? '',
      fatherId: map['fatherId'],
      motherId: map['motherId'],
      siblingsIds: List<String>.from(map['siblingsIds'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'animalId': animalId,
      'fatherId': fatherId,
      'motherId': motherId,
      'siblingsIds': siblingsIds,
    };
  }
}
