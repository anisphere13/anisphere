import 'package:hive/hive.dart';

part 'user_model.g.dart'; // Généré avec build_runner pour Hive

@HiveType(typeId: 0) // Identifiant unique pour Hive
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String profilePicture;

  @HiveField(5)
  final String profession;

  @HiveField(6)
  final Map<String, bool> ownedSpecies;

  @HiveField(7)
  final List<String> ownedAnimals;

  @HiveField(8)
  final Map<String, dynamic> preferences;

  @HiveField(9)
  final Map<String, dynamic> moduleRoles;

  @HiveField(10)
  final DateTime createdAt;

  @HiveField(11)
  DateTime updatedAt; // 🔄 Mutable pour être mis à jour facilement

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profilePicture,
    required this.profession,
    required this.ownedSpecies,
    required this.ownedAnimals,
    required this.preferences,
    required this.moduleRoles,
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
      'email': email,
      'phone': phone,
      'profilePicture': profilePicture,
      'profession': profession,
      'ownedSpecies': ownedSpecies,
      'ownedAnimals': ownedAnimals,
      'preferences': preferences,
      'moduleRoles': moduleRoles,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// 🔄 **Créer un objet UserModel à partir d'une Map (Firebase)**
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      profession: json['profession'] ?? '',
      ownedSpecies: json['ownedSpecies']?.cast<String, bool>() ?? {},
      ownedAnimals: json['ownedAnimals']?.cast<String>() ?? [],
      preferences: json['preferences']?.cast<String, dynamic>() ?? {},
      moduleRoles: json['moduleRoles']?.cast<String, dynamic>() ?? {},
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  /// 🔄 **Créer une copie de l'utilisateur avec des valeurs modifiées**
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profilePicture,
    String? profession,
    Map<String, bool>? ownedSpecies,
    List<String>? ownedAnimals,
    Map<String, dynamic>? preferences,
    Map<String, dynamic>? moduleRoles,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePicture: profilePicture ?? this.profilePicture,
      profession: profession ?? this.profession,
      ownedSpecies: ownedSpecies ?? Map<String, bool>.from(this.ownedSpecies),
      ownedAnimals: ownedAnimals ?? List<String>.from(this.ownedAnimals),
      preferences: preferences ?? Map<String, dynamic>.from(this.preferences),
      moduleRoles: moduleRoles ?? Map<String, dynamic>.from(this.moduleRoles),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

