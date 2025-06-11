library;

import 'package:hive/hive.dart';

part 'conversation_model.g.dart';

@HiveType(typeId: 71)
class ConversationModel {
  @HiveField(0)
  final List<String> participants;

  @HiveField(1)
  final String lastMessage;

  @HiveField(2)
  final DateTime lastTimestamp;

  @HiveField(3)
  final String module;

  ConversationModel({
    this.participants = const [],
    this.lastMessage = '',
    DateTime? lastTimestamp,
    this.module = '',
  }) : lastTimestamp = lastTimestamp ?? DateTime.now();

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      participants: List<String>.from(json['participants'] ?? []),
      lastMessage: json['lastMessage'] ?? '',
      lastTimestamp:
          DateTime.tryParse(json['lastTimestamp'] ?? '') ?? DateTime.now(),
      module: json['module'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'participants': participants,
        'lastMessage': lastMessage,
        'lastTimestamp': lastTimestamp.toIso8601String(),
        'module': module,
      };

  ConversationModel copyWith({
    List<String>? participants,
    String? lastMessage,
    DateTime? lastTimestamp,
    String? module,
  }) {
    return ConversationModel(
      participants: participants ?? this.participants,
      lastMessage: lastMessage ?? this.lastMessage,
      lastTimestamp: lastTimestamp ?? this.lastTimestamp,
      module: module ?? this.module,
    );
  }
}
