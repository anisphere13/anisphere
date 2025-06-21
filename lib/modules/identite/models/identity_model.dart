import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'identity_model.g.dart';

/// Modèle IdentityModel pour AniSphère.
/// Contient les champs d'identité animale (puce, race, photo, statut),
/// badge IA, historique, statut juridique, QR et photo validée IA.
/// Compatible Hive + Firebase. Prévu pour IA locale et sync différée.

@HiveType(typeId: 40)
class IdentityModel {
  @HiveField(0)
  final String animalId;

  @HiveField(1)
  final String? microchipNumber;

  @HiveField(2)
  final String? photoUrl;

  @HiveField(3)
  final String? status; // actif, perdu, en transfert, etc.

  @HiveField(4)
  final String? legalStatus; // chien d’assistance, etc.

  @HiveField(5)
  final bool verifiedByIA;

  @HiveField(6)
  final List<IdentityChange> history;

  @HiveField(7)
  final bool hasPublicQR;

  @HiveField(8)
  final DateTime lastUpdate;

  @HiveField(9)
  final double aiScore;

  @HiveField(10)
  final bool verifiedBreed;

  IdentityModel({
    required this.animalId,
    this.microchipNumber,
    this.photoUrl,
    this.status,
    this.legalStatus,
    this.verifiedByIA = false,
    this.history = const [],
    this.hasPublicQR = false,
    DateTime? lastUpdate,
    this.aiScore = 0.0,
    this.verifiedBreed = false,
  }) : lastUpdate = lastUpdate ?? DateTime.now();

  factory IdentityModel.fromMap(Map<String, dynamic> map) {
    return IdentityModel(
      animalId: map['animalId'],
      microchipNumber: map['microchipNumber'],
      photoUrl: map['photoUrl'],
      status: map['status'],
      legalStatus: map['legalStatus'],
      verifiedByIA: map['verifiedByIA'] ?? false,
      history: (map['history'] as List<dynamic>? ?? [])
          .map((e) => IdentityChange.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      hasPublicQR: map['hasPublicQR'] ?? false,
      lastUpdate: (map['lastUpdate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      aiScore: (map['aiScore'] as num?)?.toDouble() ?? 0.0,
      verifiedBreed: map['verifiedBreed'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'animalId': animalId,
      'microchipNumber': microchipNumber,
      'photoUrl': photoUrl,
      'status': status,
      'legalStatus': legalStatus,
      'verifiedByIA': verifiedByIA,
      'history': history.map((e) => e.toMap()).toList(),
      'hasPublicQR': hasPublicQR,
      'lastUpdate': Timestamp.fromDate(lastUpdate),
      'aiScore': aiScore,
      'verifiedBreed': verifiedBreed,
    };
  }
}

@HiveType(typeId: 41)
class IdentityChange {
  @HiveField(0)
  final String field;
  
  @HiveField(1)
  final String oldValue;
  
  @HiveField(2)
  final String newValue;

  @HiveField(3)
  final DateTime date;

  IdentityChange({
    required this.field,
    required this.oldValue,
    required this.newValue,
    required this.date,
  });

  factory IdentityChange.fromMap(Map<String, dynamic> map) {
    return IdentityChange(
      field: map['field'],
      oldValue: map['oldValue'],
      newValue: map['newValue'],
      date: (map['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'field': field,
      'oldValue': oldValue,
      'newValue': newValue,
      'date': Timestamp.fromDate(date),
    };
  }
}
