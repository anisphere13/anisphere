library;

import 'package:hive/hive.dart';

part 'gps_tracker_model.g.dart';

// Copilot: Modèle pour enregistrer les positions GPS et leur contexte IA.
@HiveType(typeId: 60)
class GpsTrackerModel {
  @HiveField(0)
  final DateTime timestamp;

  @HiveField(1)
  final double latitude;

  @HiveField(2)
  final double longitude;

  @HiveField(3)
  final String context;

  @HiveField(4)
  final List<String> iaTags;

  const GpsTrackerModel({
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    required this.context,
    required this.iaTags,
  });

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.toIso8601String(),
        'latitude': latitude,
        'longitude': longitude,
        'context': context,
        'iaTags': iaTags,
      };

  factory GpsTrackerModel.fromJson(Map<String, dynamic> json) {
    return GpsTrackerModel(
      timestamp:
          DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      context: json['context'] ?? '',
      iaTags: List<String>.from(json['iaTags'] ?? const []),
    );
  }

  GpsTrackerModel copyWith({
    DateTime? timestamp,
    double? latitude,
    double? longitude,
    String? context,
    List<String>? iaTags,
  }) {
    return GpsTrackerModel(
      timestamp: timestamp ?? this.timestamp,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      context: context ?? this.context,
      iaTags: iaTags ?? this.iaTags,
    );
  }
}
