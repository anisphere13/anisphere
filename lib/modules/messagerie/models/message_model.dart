library;

import 'package:hive/hive.dart';

part 'message_model.g.dart';

@HiveType(typeId: 60)
class MessageModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String conversationId;

  @HiveField(2)
  final String senderId;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final DateTime createdAt;

  const MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.createdAt,
  });

  MessageModel copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? content,
    DateTime? createdAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'conversationId': conversationId,
        'senderId': senderId,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
      };

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      conversationId: json['conversationId'] ?? '',
      senderId: json['senderId'] ?? '',
      content: json['content'] ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
