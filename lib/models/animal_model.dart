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
  final String ownerId; // ID du propriétaire

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  DateTime updatedAt; // 🔄 Mutable pour être mis à jour facilement

  AnimalModel({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.imageUrl,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 🔄 **Mettre à jour `updatedAt`**
  void updateTimestamp() {
    updatedAt = DateTime.now();
  }

  /// 🔄 **Convertir l'objet en Map pour Firebase**
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
    };
  }

  /// 🔄 **Créer un objet AnimalModel à partir d'une Map (Firebase)**
  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    return AnimalModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      species: json['species'] ?? '',
      breed: json['breed'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      ownerId: json['ownerId'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  /// 🔄 **Créer une copie de l'animal avec des valeurs modifiées**
  AnimalModel copyWith({
    String? id,
    String? name,
    String? species,
    String? breed,
    String? imageUrl,
    String? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
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
    );
  }
}


