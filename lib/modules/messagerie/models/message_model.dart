library;

import 'package:hive/hive.dart';

part 'message_model.g.dart';

/// Model representing a chat message.
@HiveType(typeId: 120)
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
  final DateTime timestamp;

  @HiveField(5)
  final bool sent;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    DateTime? timestamp,
    this.sent = false,
  }) : timestamp = timestamp ?? DateTime.now();

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? '',
      conversationId: map['conversationId'] ?? '',
      senderId: map['senderId'] ?? '',
      content: map['content'] ?? '',
      timestamp: DateTime.tryParse(map['timestamp'] ?? '') ?? DateTime.now(),
      sent: map['sent'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conversationId': conversationId,
      'senderId': senderId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'sent': sent,
    };
  }

  MessageModel copyWith({bool? sent}) {
    return MessageModel(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      content: content,
      timestamp: timestamp,
      sent: sent ?? this.sent,
    );
  }
}
