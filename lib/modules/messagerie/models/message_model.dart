library;
// TODO: ajouter test

import 'package:hive/hive.dart';

part 'message_model.g.dart';

@HiveType(typeId: 70)
class MessageModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String conversationId;

  @HiveField(2)
  final String senderId;

  @HiveField(3)
  final String receiverId;

  @HiveField(4)
  final String content;

  @HiveField(5)
  final DateTime timestamp;

  @HiveField(6)
  final bool sent;

  @HiveField(7)
  final String moduleContext;

  @HiveField(8)
  final int priority;

  @HiveField(9)
  final String status;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    this.receiverId = '',
    required this.content,
    DateTime? timestamp,
    bool? sent,
    this.moduleContext = '',
    this.priority = 0,
    this.status = '',
  })  : timestamp = timestamp ?? DateTime.now(),
        sent = sent ?? false;

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      conversationId: json['conversationId'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      content: json['content'] ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      sent: json['sent'] ?? false,
      moduleContext: json['moduleContext'] ?? '',
      priority: json['priority'] ?? 0,
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'conversationId': conversationId,
        'senderId': senderId,
        'receiverId': receiverId,
        'content': content,
        'timestamp': timestamp.toIso8601String(),
        'sent': sent,
        'moduleContext': moduleContext,
        'priority': priority,
        'status': status,
      };

  Map<String, dynamic> toMap() => toJson();

  MessageModel copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? receiverId,
    String? content,
    DateTime? timestamp,
    bool? sent,
    String? moduleContext,
    int? priority,
    String? status,
  }) {
    return MessageModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      sent: sent ?? this.sent,
      moduleContext: moduleContext ?? this.moduleContext,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }
}
