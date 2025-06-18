
import 'package:hive/hive.dart';

part 'event_model.g.dart';

/// Base event model used by [EventBusService].
@HiveType(typeId: 160)
class EventModel {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final Map<String, dynamic> payload;

  @HiveField(2)
  final DateTime timestamp;

  @HiveField(3)
  final String sender;

  @HiveField(4)
  final String scope;

  EventModel({
    required this.type,
    Map<String, dynamic>? payload,
    DateTime? timestamp,
    this.sender = '',
    this.scope = 'global',
  })  : payload = payload ?? const {},
        timestamp = timestamp ?? DateTime.now();

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        type: json['type'] ?? '',
        payload: Map<String, dynamic>.from(json['payload'] ?? {}),
        timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
        sender: json['sender'] ?? '',
        scope: json['scope'] ?? 'global',
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'payload': payload,
        'timestamp': timestamp.toIso8601String(),
        'sender': sender,
        'scope': scope,
      };

  EventModel copyWith({
    String? type,
    Map<String, dynamic>? payload,
    DateTime? timestamp,
    String? sender,
    String? scope,
  }) {
    return EventModel(
      type: type ?? this.type,
      payload: payload ?? Map<String, dynamic>.from(this.payload),
      timestamp: timestamp ?? this.timestamp,
      sender: sender ?? this.sender,
      scope: scope ?? this.scope,
    );
  }
}
