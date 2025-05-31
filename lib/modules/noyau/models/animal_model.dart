/// Copilot Prompt : Modèle d’animal pour AniSphère.
/// Stockage Hive + export Firebase (toJson/fromJson), copie, updateAt.
/// Champs : identité, espèce, race, image, date de naissance, propriétaire, timestamps.
/// Utilisé dans le noyau pour la gestion des animaux.

library;

import 'package:hive/hive.dart';

part 'animal_model.g.dart';

@HiveType(typeId: 1)
class AnimalModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String species;

  @HiveField(3)
  final String breed;

  @HiveField(4)
  final String imageUrl;

  @HiveField(5)
  final String ownerId;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final DateTime updatedAt;

  @HiveField(8)
  final DateTime? birthDate;

  const AnimalModel({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.imageUrl,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    this.birthDate,
  });

  /// 🔄 Convertir l'objet en Map pour Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'breed': breed,
      'imageUrl': imageUrl,
      'ownerId': ownerId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'birthDate': birthDate?.toIso8601String(),
    };
  }

  /// 🔄 Créer un objet AnimalModel à partir d'une Map (Firebase)
  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    return AnimalModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      species: json['species'] ?? '',
      breed: json['breed'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      ownerId: json['ownerId'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      birthDate: json['birthDate'] != null
          ? DateTime.tryParse(json['birthDate'])
          : null,
    );
  }

  AnimalModel copyWith({
    String? id,
    String? name,
    String? species,
    String? breed,
    String? imageUrl,
    String? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? birthDate,
  }) {
    return AnimalModel(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      breed: breed ?? this.breed,
      imageUrl: imageUrl ?? this.imageUrl,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      birthDate: birthDate ?? this.birthDate,
    );
  }
}
