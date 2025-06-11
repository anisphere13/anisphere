library;

import 'package:hive/hive.dart';

part 'conversation_model.g.dart';

@HiveType(typeId: 71)
class ConversationModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<String> participantIds;

  @HiveField(2)
  final String lastMessage;

  @HiveField(3)
  final DateTime lastTimestamp;

  @HiveField(4)
  final String moduleName;

  ConversationModel({
    required this.id,
    this.participantIds = const [],
    this.lastMessage = '',
    DateTime? lastTimestamp,
    this.moduleName = '',
  }) : lastTimestamp = lastTimestamp ?? DateTime.now();

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? '',
      participantIds: List<String>.from(json['participantIds'] ?? []),
      lastMessage: json['lastMessage'] ?? '',
      lastTimestamp:
          DateTime.tryParse(json['lastTimestamp'] ?? '') ?? DateTime.now(),
      moduleName: json['moduleName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'participantIds': participantIds,
        'lastMessage': lastMessage,
        'lastTimestamp': lastTimestamp.toIso8601String(),
        'moduleName': moduleName,
      };

  ConversationModel copyWith({
    String? id,
    List<String>? participantIds,
    String? lastMessage,
    DateTime? lastTimestamp,
    String? moduleName,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      participantIds: participantIds ?? this.participantIds,
      lastMessage: lastMessage ?? this.lastMessage,
      lastTimestamp: lastTimestamp ?? this.lastTimestamp,
      moduleName: moduleName ?? this.moduleName,
    );
  }
}
