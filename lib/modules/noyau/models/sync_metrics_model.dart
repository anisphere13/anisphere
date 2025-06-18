
import 'package:hive/hive.dart';

part 'sync_metrics_model.g.dart';

@HiveType(typeId: 25)
class SyncMetricsModel {
  @HiveField(0)
  final String operation;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final bool success;

  @HiveField(3)
  final String details;

  const SyncMetricsModel({
    required this.operation,
    required this.timestamp,
    required this.success,
    required this.details,
  });

  Map<String, dynamic> toJson() => {
        'operation': operation,
        'timestamp': timestamp.toIso8601String(),
        'success': success,
        'details': details,
      };

  factory SyncMetricsModel.fromJson(Map<String, dynamic> json) {
    return SyncMetricsModel(
      operation: json['operation'] ?? '',
      timestamp:
          DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      success: json['success'] ?? false,
      details: json['details'] ?? '',
    );
  }

  SyncMetricsModel copyWith({
    String? operation,
    DateTime? timestamp,
    bool? success,
    String? details,
  }) {
    return SyncMetricsModel(
      operation: operation ?? this.operation,
      timestamp: timestamp ?? this.timestamp,
      success: success ?? this.success,
      details: details ?? this.details,
    );
  }
}
