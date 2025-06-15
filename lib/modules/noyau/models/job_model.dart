library;

/// Possible states for a scheduled job.
enum JobStatus { pending, running, completed, failed }

/// Model representing a scheduled job.
class JobModel {
  final String id;
  final String name;
  JobStatus status;
  final DateTime createdAt;
  DateTime? startedAt;
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
