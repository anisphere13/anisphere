// Copilot Prompt : Modèle utilisateur AniSphère complet pour IA hybride (Hive + Firebase).
// Sérialisable Hive et Firebase. Contient rôles, préférences, animaux, timestamps.
// Prévu pour une app IA, offline-first, multi-rôle et multi-module.
// TODO: Badges IA payants


import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
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
  final DateTime updatedAt;

  @HiveField(12)
  final List<String> activeModules;

  @HiveField(13)
  final String role;

  @HiveField(14)
  final bool iaPremium;

  @HiveField(15)
  final DateTime? lastIASync;

  @HiveField(16)
  final bool iaTrained;

  @HiveField(17)
  final DateTime? syncedAt;

  @HiveField(18)
  final String? langue;

  @HiveField(19)
  final String address;

  @HiveField(20)
  final DateTime? birthDate;

  const UserModel({
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
    required this.activeModules,
    required this.role,
    required this.iaPremium,
    this.lastIASync,
    this.iaTrained = false,
    this.syncedAt,
    this.langue,
    this.address = '',
    this.birthDate,
  });

  Map<String, dynamic> toJson() => {
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
        'activeModules': activeModules,
        'role': role,
        'iaPremium': iaPremium,
        'lastIASync': lastIASync?.toIso8601String(),
        'iaTrained': iaTrained,
        'syncedAt': syncedAt?.toIso8601String(),
        'langue': langue,
        'address': address,
        'birthDate': birthDate?.toIso8601String(),
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      profession: json['profession'] ?? '',
      ownedSpecies: Map<String, bool>.from(json['ownedSpecies'] ?? {}),
      ownedAnimals: List<String>.from(json['ownedAnimals'] ?? []),
      preferences: Map<String, dynamic>.from(json['preferences'] ?? {}),
      moduleRoles: Map<String, dynamic>.from(json['moduleRoles'] ?? {}),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      activeModules: List<String>.from(json['activeModules'] ?? []),
      role: json['role'] ?? 'user',
      iaPremium: json['iaPremium'] ?? false,
      lastIASync: json['lastIASync'] != null
          ? DateTime.tryParse(json['lastIASync'])
          : null,
      iaTrained: json['iaTrained'] ?? false,
      syncedAt: json['syncedAt'] != null
          ? DateTime.tryParse(json['syncedAt'])
          : null,
      langue: json['langue'],
      address: json['address'] ?? '',
      birthDate: json['birthDate'] != null
          ? DateTime.tryParse(json['birthDate'])
          : null,
    );
  }

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
    List<String>? activeModules,
    String? role,
    bool? iaPremium,
    DateTime? lastIASync,
    bool? iaTrained,
    DateTime? syncedAt,
    String? langue,
    String? address,
    DateTime? birthDate,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePicture: profilePicture ?? this.profilePicture,
      profession: profession ?? this.profession,
      ownedSpecies: ownedSpecies ?? this.ownedSpecies,
      ownedAnimals: ownedAnimals ?? this.ownedAnimals,
      preferences: preferences ?? this.preferences,
      moduleRoles: moduleRoles ?? this.moduleRoles,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      activeModules: activeModules ?? this.activeModules,
      role: role ?? this.role,
      iaPremium: iaPremium ?? this.iaPremium,
      lastIASync: lastIASync ?? this.lastIASync,
      iaTrained: iaTrained ?? this.iaTrained,
      syncedAt: syncedAt ?? this.syncedAt,
      langue: langue ?? this.langue,
      address: address ?? this.address,
      birthDate: birthDate ?? this.birthDate,
    );
  }
}
