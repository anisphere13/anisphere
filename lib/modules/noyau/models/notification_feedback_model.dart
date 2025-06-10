library;

import 'package:hive/hive.dart';

part 'notification_feedback_model.g.dart';

@HiveType(typeId: 24)
class NotificationFeedbackModel {
  @HiveField(0)
  final String notificationId;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final DateTime openedAt;

  @HiveField(3)
  final String reaction;

  @HiveField(4)
  final String module;

  @HiveField(5)
  final String type;

  @HiveField(6)
  final DateTime createdAt;

  const NotificationFeedbackModel({
    required this.notificationId,
    required this.userId,
    required this.openedAt,
    required this.reaction,
    required this.module,
    required this.type,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'notificationId': notificationId,
        'userId': userId,
        'openedAt': openedAt.toIso8601String(),
        'reaction': reaction,
        'module': module,
        'type': type,
        'createdAt': createdAt.toIso8601String(),
      };

  factory NotificationFeedbackModel.fromJson(Map<String, dynamic> json) {
    return NotificationFeedbackModel(
      notificationId: json['notificationId'] ?? '',
      userId: json['userId'] ?? '',
      openedAt:
          DateTime.tryParse(json['openedAt'] ?? '') ?? DateTime.now(),
      reaction: json['reaction'] ?? '',
      module: json['module'] ?? '',
      type: json['type'] ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  NotificationFeedbackModel copyWith({
    String? notificationId,
    String? userId,
    DateTime? openedAt,
    String? reaction,
    String? module,
    String? type,
    DateTime? createdAt,
  }) {
    return NotificationFeedbackModel(
      notificationId: notificationId ?? this.notificationId,
      userId: userId ?? this.userId,
      openedAt: openedAt ?? this.openedAt,
      reaction: reaction ?? this.reaction,
      module: module ?? this.module,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
