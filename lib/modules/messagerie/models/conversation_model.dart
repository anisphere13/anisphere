library;

import 'package:hive/hive.dart';

part 'conversation_model.g.dart';

@HiveType(typeId: 61)
class ConversationModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String moduleName;

  @HiveField(2)
  final List<String> participantIds;

  @HiveField(3)
  final String lastMessage;

  @HiveField(4)
  final DateTime updatedAt;

  const ConversationModel({
    required this.id,
    required this.moduleName,
    required this.participantIds,
    required this.lastMessage,
    required this.updatedAt,
  });

  ConversationModel copyWith({
    String? id,
    String? moduleName,
    List<String>? participantIds,
    String? lastMessage,
    DateTime? updatedAt,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      moduleName: moduleName ?? this.moduleName,
      participantIds: participantIds ?? this.participantIds,
      lastMessage: lastMessage ?? this.lastMessage,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'moduleName': moduleName,
        'participantIds': participantIds,
        'lastMessage': lastMessage,
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? '',
      moduleName: json['moduleName'] ?? '',
      participantIds: List<String>.from(json['participantIds'] ?? []),
      lastMessage: json['lastMessage'] ?? '',
      updatedAt:
          DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}
