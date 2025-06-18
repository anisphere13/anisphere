
import 'package:hive/hive.dart';

part 'consent_model.g.dart';

@HiveType(typeId: 26)
class ConsentModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final String module;

  @HiveField(3)
  final DateTime acceptedAt;

  @HiveField(4)
  final int cguVersion;

  @HiveField(5)
  final List<String> scope;

  @HiveField(6)
  final DateTime? revokedAt;

  const ConsentModel({
    required this.id,
    required this.type,
    required this.module,
    required this.acceptedAt,
    required this.cguVersion,
    required this.scope,
    this.revokedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'module': module,
        'acceptedAt': acceptedAt.toIso8601String(),
        'cguVersion': cguVersion,
        'scope': scope,
        'revokedAt': revokedAt?.toIso8601String(),
      };

  factory ConsentModel.fromJson(Map<String, dynamic> json) {
    return ConsentModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      module: json['module'] ?? '',
      acceptedAt:
          DateTime.tryParse(json['acceptedAt'] ?? '') ?? DateTime.now(),
      cguVersion: json['cguVersion'] ?? 1,
      scope: List<String>.from(json['scope'] ?? []),
      revokedAt:
          json['revokedAt'] != null ? DateTime.tryParse(json['revokedAt']) : null,
    );
  }

  ConsentModel copyWith({
    String? id,
    String? type,
    String? module,
    DateTime? acceptedAt,
    int? cguVersion,
    List<String>? scope,
    DateTime? revokedAt,
  }) {
    return ConsentModel(
      id: id ?? this.id,
      type: type ?? this.type,
      module: module ?? this.module,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      cguVersion: cguVersion ?? this.cguVersion,
      scope: scope ?? this.scope,
      revokedAt: revokedAt ?? this.revokedAt,
    );
  }
}
