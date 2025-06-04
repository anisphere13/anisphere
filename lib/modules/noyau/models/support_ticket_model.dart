/// Copilot Prompt : Modèle de support et feedback pour AniSphère.
/// Permet à l'utilisateur de signaler un bug, proposer une idée ou contacter l'équipe.
/// Compatible Hive et Firebase.
library;

import 'package:hive/hive.dart';

part 'support_ticket_model.g.dart';

@HiveType(typeId: 21)
class SupportTicketModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String type; // bug, idee, autre

  @HiveField(3)
  final String message;

  @HiveField(4)
  final String status; // brouillon, en_cours, resolu

  @HiveField(5)
  final String logs;

  @HiveField(6)
  final String aiResponse;

  @HiveField(7)
  final String adminNote;

  @HiveField(8)
  final DateTime createdAt;

  @HiveField(9)
  final DateTime updatedAt;

  @HiveField(10)
  final String moduleName;

  @HiveField(11)
  final List<String> attachments;

  const SupportTicketModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.message,
    this.status = 'brouillon',
    this.logs = '',
    this.aiResponse = '',
    this.adminNote = '',
    required this.createdAt,
    required this.updatedAt,
    this.moduleName = '',
    this.attachments = const [],
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'type': type,
        'message': message,
        'status': status,
        'logs': logs,
        'aiResponse': aiResponse,
        'adminNote': adminNote,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'moduleName': moduleName,
        'attachments': attachments,
      };

  factory SupportTicketModel.fromJson(Map<String, dynamic> json) {
    return SupportTicketModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      type: json['type'] ?? 'bug',
      message: json['message'] ?? '',
      status: json['status'] ?? 'brouillon',
      logs: json['logs'] ?? '',
      aiResponse: json['aiResponse'] ?? '',
      adminNote: json['adminNote'] ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      moduleName: json['moduleName'] ?? '',
      attachments: List<String>.from(json['attachments'] ?? []),
    );
  }

  SupportTicketModel copyWith({
    String? id,
    String? userId,
    String? type,
    String? message,
    String? status,
    String? logs,
    String? aiResponse,
    String? adminNote,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? moduleName,
    List<String>? attachments,
  }) {
    return SupportTicketModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      message: message ?? this.message,
      status: status ?? this.status,
      logs: logs ?? this.logs,
      aiResponse: aiResponse ?? this.aiResponse,
      adminNote: adminNote ?? this.adminNote,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      moduleName: moduleName ?? this.moduleName,
      attachments: attachments ?? this.attachments,
    );
  }
}
