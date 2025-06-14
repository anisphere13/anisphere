library;

import 'package:hive/hive.dart';

part 'share_history_model.g.dart';

@HiveType(typeId: 30)
class ShareHistoryModel {
  @HiveField(0)
  final String mode; // 'local' or 'cloud'

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final bool success;

  @HiveField(3)
  final String feedback;

  @HiveField(4)
  final double cost;

  const ShareHistoryModel({
    required this.mode,
    required this.date,
    required this.success,
    this.feedback = '',
    this.cost = 0.0,
  });

  Map<String, dynamic> toJson() => {
        'mode': mode,
        'date': date.toIso8601String(),
        'success': success,
        'feedback': feedback,
        'cost': cost,
      };

  factory ShareHistoryModel.fromJson(Map<String, dynamic> json) {
    return ShareHistoryModel(
      mode: json['mode'] ?? 'local',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      success: json['success'] ?? false,
      feedback: json['feedback'] ?? '',
      cost: (json['cost'] as num?)?.toDouble() ?? 0.0,
    );
  }

  ShareHistoryModel copyWith({
    String? mode,
    DateTime? date,
    bool? success,
    String? feedback,
    double? cost,
  }) {
    return ShareHistoryModel(
      mode: mode ?? this.mode,
      date: date ?? this.date,
      success: success ?? this.success,
      feedback: feedback ?? this.feedback,
      cost: cost ?? this.cost,
    );
  }
}
