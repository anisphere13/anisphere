
class TestResultModel {
  final String id;
  final bool success;
  final String logs;
  final String aiResponse;
  final DateTime createdAt;

  TestResultModel({
    required this.id,
    required this.success,
    this.logs = '',
    this.aiResponse = '',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'success': success,
        'logs': logs,
        'aiResponse': aiResponse,
        'createdAt': createdAt.toIso8601String(),
      };

  factory TestResultModel.fromJson(Map<String, dynamic> json) {
    return TestResultModel(
      id: json['id'] ?? '',
      success: json['success'] ?? false,
      logs: json['logs'] ?? '',
      aiResponse: json['aiResponse'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}