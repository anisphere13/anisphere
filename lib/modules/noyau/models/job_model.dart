library;

import 'package:hive/hive.dart';

part 'job_model.g.dart';

@HiveType(typeId: 130)
class JobModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final String target;

  @HiveField(3)
  final DateTime nextRun;

  @HiveField(4)
  final String status;

  @HiveField(5)
  final int attempt;

  @HiveField(6)
  final List<String> logs;

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final DateTime updatedAt;

  const JobModel({
    required this.id,
    required this.type,
    required this.target,
    required this.nextRun,
    this.status = 'pending',
    this.attempt = 0,
    this.logs = const [],
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  JobModel copyWith({
    String? id,
    String? type,
    String? target,
    DateTime? nextRun,
    String? status,
    int? attempt,
    List<String>? logs,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return JobModel(
      id: id ?? this.id,
      type: type ?? this.type,
      target: target ?? this.target,
      nextRun: nextRun ?? this.nextRun,
      status: status ?? this.status,
      attempt: attempt ?? this.attempt,
      logs: logs ?? this.logs,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      target: json['target'] ?? '',
      nextRun: DateTime.tryParse(json['nextRun'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 'pending',
      attempt: json['attempt'] ?? 0,
      logs: (json['logs'] as List?)?.cast<String>() ?? const [],
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'target': target,
        'nextRun': nextRun.toIso8601String(),
        'status': status,
        'attempt': attempt,
        'logs': logs,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
