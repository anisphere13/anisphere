/// Copilot Prompt : Modèle de support et feedback pour AniSphère.
/// Permet à l'utilisateur de signaler un bug, proposer une idée ou contacter l'équipe.
/// Compatible Hive et Firebase.

library;

import 'package:hive/hive.dart';

part 'support_model.g.dart';

@HiveType(typeId: 20)
class SupportModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String type; // bug, idee, contact

  @HiveField(3)
  final String message;

  @HiveField(4)
  final String status; // brouillon, lu, traite

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final DateTime updatedAt;

  @HiveField(7)
  final List<String> attachments;

  const SupportModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.message,
    this.status = 'brouillon',
    required this.createdAt,
    required this.updatedAt,
    this.attachments = const [],
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'type': type,
        'message': message,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'attachments': attachments,
      };

  factory SupportModel.fromJson(Map<String, dynamic> json) {
    return SupportModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      type: json['type'] ?? 'bug',
      message: json['message'] ?? '',
      status: json['status'] ?? 'brouillon',
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      attachments: List<String>.from(json['attachments'] ?? []),
    );
  }

  SupportModel copyWith({
    String? id,
    String? userId,
    String? type,
    String? message,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? attachments,
  }) {
    return SupportModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      message: message ?? this.message,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      attachments: attachments ?? this.attachments,
    );
  }
}
