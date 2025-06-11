library;

import 'package:hive/hive.dart';

part 'conversation_model.g.dart';

@HiveType(typeId: 71)
class ConversationModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<String> participants;

  @HiveField(2)
  final String lastMessage;

  @HiveField(3)
  final DateTime lastTimestamp;

  @HiveField(4)
  final String module;

  String get moduleName => module;

  List<String> get participantIds => participants;

  ConversationModel({
    required this.id,
    this.participants = const [],
    this.lastMessage = '',
    DateTime? lastTimestamp,
    this.module = '',
  }) : lastTimestamp = lastTimestamp ?? DateTime.now();

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? '',
      participants: List<String>.from(json['participants'] ?? []),
      lastMessage: json['lastMessage'] ?? '',
      lastTimestamp:
          DateTime.tryParse(json['lastTimestamp'] ?? '') ?? DateTime.now(),
      module: json['module'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'participants': participants,
        'lastMessage': lastMessage,
        'lastTimestamp': lastTimestamp.toIso8601String(),
        'module': module,
      };

  ConversationModel copyWith({
    String? id,
    List<String>? participants,
    String? lastMessage,
    DateTime? lastTimestamp,
    String? module,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      participants: participants ?? this.participants,
      lastMessage: lastMessage ?? this.lastMessage,
      lastTimestamp: lastTimestamp ?? this.lastTimestamp,
      module: module ?? this.module,
    );
  }
}
