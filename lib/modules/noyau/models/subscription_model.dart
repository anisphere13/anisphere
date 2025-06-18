// Copilot Prompt : Modèle d'abonnement utilisateur pour AniSphère.

import 'package:hive/hive.dart';

part 'subscription_model.g.dart';

@HiveType(typeId: 90)
enum SubscriptionStatus {
  @HiveField(0)
  active,
  @HiveField(1)
  expired,
  @HiveField(2)
  cancelled,
}

@HiveType(typeId: 91)
class SubscriptionModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final DateTime startDate;

  @HiveField(4)
  final DateTime expiryDate;

  @HiveField(5)
  final SubscriptionStatus status;

  @HiveField(6)
  final DateTime? lastSync;

  const SubscriptionModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.startDate,
    required this.expiryDate,
    this.status = SubscriptionStatus.active,
    this.lastSync,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'type': type,
        'startDate': startDate.toIso8601String(),
        'expiryDate': expiryDate.toIso8601String(),
        'status': status.name,
        'lastSync': lastSync?.toIso8601String(),
      };

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    SubscriptionStatus parsedStatus;
    try {
      parsedStatus = SubscriptionStatus.values
          .firstWhere((e) => e.name == json['status']);
    } catch (_) {
      parsedStatus = SubscriptionStatus.active;
    }
    return SubscriptionModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      type: json['type'] ?? '',
      startDate:
          DateTime.tryParse(json['startDate'] ?? '') ?? DateTime.now(),
      expiryDate:
          DateTime.tryParse(json['expiryDate'] ?? '') ?? DateTime.now(),
      status: parsedStatus,
      lastSync: json['lastSync'] != null
          ? DateTime.tryParse(json['lastSync'])
          : null,
    );
  }

  SubscriptionModel copyWith({
    String? id,
    String? userId,
    String? type,
    DateTime? startDate,
    DateTime? expiryDate,
    SubscriptionStatus? status,
    DateTime? lastSync,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      expiryDate: expiryDate ?? this.expiryDate,
      status: status ?? this.status,
      lastSync: lastSync ?? this.lastSync,
    );
  }
}
