library;

import 'package:hive/hive.dart';

part 'consent_entry.g.dart';

@HiveType(typeId: 60)
enum ConsentAction {
  @HiveField(0)
  accepted,
  @HiveField(1)
  declined,
  @HiveField(2)
  exportRequested,
  @HiveField(3)
  deletionRequested,
}

@HiveType(typeId: 61)
class ConsentEntry {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final ConsentAction action;
  @HiveField(3)
  final DateTime timestamp;

  const ConsentEntry({
    required this.id,
    required this.userId,
    required this.action,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'action': action.name,
        'timestamp': timestamp.toIso8601String(),
      };

  factory ConsentEntry.fromJson(Map<String, dynamic> json) {
    ConsentAction act;
    try {
      act = ConsentAction.values.firstWhere((a) => a.name == json['action']);
    } catch (_) {
      act = ConsentAction.accepted;
    }
    return ConsentEntry(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      action: act,
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }
}
