library;

import 'package:hive/hive.dart';

part 'job_model.g.dart';

/// Possible states for a scheduled job.
@HiveType(typeId: 129)
enum JobStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  running,
  @HiveField(2)
  completed,
  @HiveField(3)
  failed
}

/// Model representing a scheduled job.
@HiveType(typeId: 130)
class JobModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  JobStatus status;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  DateTime? startedAt;

  @HiveField(5)
  DateTime? finishedAt;

  JobModel({
    required this.id,
    required this.name,
    this.status = JobStatus.pending,
    DateTime? createdAt,
    this.startedAt,
    this.finishedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  JobModel copyWith({
    String? id,
    String? name,
    JobStatus? status,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? finishedAt,
  }) {
    return JobModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
        'startedAt': startedAt?.toIso8601String(),
        'finishedAt': finishedAt?.toIso8601String(),
      };

  factory JobModel.fromJson(Map<String, dynamic> json) {
    JobStatus parsedStatus;
    try {
      parsedStatus = JobStatus.values
          .firstWhere((e) => e.name == json['status']);
    } catch (_) {
      parsedStatus = JobStatus.pending;
    }
    return JobModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      status: parsedStatus,
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      startedAt: json['startedAt'] != null
          ? DateTime.tryParse(json['startedAt'])
          : null,
      finishedAt: json['finishedAt'] != null
          ? DateTime.tryParse(json['finishedAt'])
          : null,
    );
  }
}
