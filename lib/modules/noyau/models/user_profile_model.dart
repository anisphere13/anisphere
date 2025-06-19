import 'package:hive/hive.dart';
import 'user_model.dart';

part 'user_profile_model.g.dart';

/// Extension du [UserModel] avec des informations professionnelles.
/// Ces données restent stockées localement (Hive) et peuvent être
/// synchronisées dans `cloud_users` via une fonction Cloud après validation.
@HiveType(typeId: 52)
class UserProfileModel extends UserModel {
  @HiveField(19)
  final String lastName;

  @HiveField(20)
  final String firstName;

  @HiveField(21)
  final String address;

  @HiveField(22)
  final DateTime? birthDate;

  @HiveField(23)
  final String birthPlace;

  @HiveField(24)
  final String unit;

  @HiveField(25)
  final String company;

  @HiveField(26)
  final String group;

  @HiveField(27)
  final String nigend;

  @HiveField(28)
  final bool proValidated;

  const UserProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.profilePicture,
    required super.profession,
    required super.ownedSpecies,
    required super.ownedAnimals,
    required super.preferences,
    required super.moduleRoles,
    required super.createdAt,
    required super.updatedAt,
    required super.activeModules,
    required super.role,
    required super.iaPremium,
    super.lastIASync,
    super.iaTrained = false,
    super.syncedAt,
    super.langue,
    this.lastName = '',
    this.firstName = '',
    this.address = '',
    this.birthDate,
    this.birthPlace = '',
    this.unit = '',
    this.company = '',
    this.group = '',
    this.nigend = '',
    this.proValidated = false,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final base = UserModel.fromJson(json);
    return UserProfileModel(
      id: base.id,
      name: base.name,
      email: base.email,
      phone: base.phone,
      profilePicture: base.profilePicture,
      profession: base.profession,
      ownedSpecies: base.ownedSpecies,
      ownedAnimals: base.ownedAnimals,
      preferences: base.preferences,
      moduleRoles: base.moduleRoles,
      createdAt: base.createdAt,
      updatedAt: base.updatedAt,
      activeModules: base.activeModules,
      role: base.role,
      iaPremium: base.iaPremium,
      lastIASync: base.lastIASync,
      iaTrained: base.iaTrained,
      syncedAt: base.syncedAt,
      langue: base.langue,
      lastName: json['lastName'] ?? '',
      firstName: json['firstName'] ?? '',
      address: json['address'] ?? '',
      birthDate: json['birthDate'] != null
          ? DateTime.tryParse(json['birthDate'])
          : null,
      birthPlace: json['birthPlace'] ?? '',
      unit: json['unit'] ?? '',
      company: json['company'] ?? '',
      group: json['group'] ?? '',
      nigend: json['nigend'] ?? '',
      proValidated: json['proValidated'] ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'lastName': lastName,
        'firstName': firstName,
        'address': address,
        'birthDate': birthDate?.toIso8601String(),
        'birthPlace': birthPlace,
        'unit': unit,
        'company': company,
        'group': group,
        'nigend': nigend,
        'proValidated': proValidated,
      };

  UserProfileModel copyWith({
    String? lastName,
    String? firstName,
    String? address,
    DateTime? birthDate,
    String? birthPlace,
    String? unit,
    String? company,
    String? group,
    String? nigend,
    bool? proValidated,
    // base fields
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
  }) {
    return UserProfileModel(
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
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      address: address ?? this.address,
      birthDate: birthDate ?? this.birthDate,
      birthPlace: birthPlace ?? this.birthPlace,
      unit: unit ?? this.unit,
      company: company ?? this.company,
      group: group ?? this.group,
      nigend: nigend ?? this.nigend,
      proValidated: proValidated ?? this.proValidated,
    );
  }
}
