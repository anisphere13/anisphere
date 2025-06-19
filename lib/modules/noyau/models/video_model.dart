// Analyse Vidéo AniSphère

import 'package:hive/hive.dart';

part 'video_model.g.dart';

@HiveType(typeId: 51)
class VideoModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String animalId;

  @HiveField(3)
  final String localPath;

  @HiveField(4)
  final int duration;

  @HiveField(5)
  final String type;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final String status;

  @HiveField(8)
  final String origin;

  const VideoModel({
    required this.id,
    required this.userId,
    required this.animalId,
    required this.localPath,
    required this.duration,
    required this.type,
    required this.createdAt,
    required this.status,
    required this.origin,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'animalId': animalId,
        'localPath': localPath,
        'duration': duration,
        'type': type,
        'createdAt': createdAt.toIso8601String(),
        'status': status,
        'origin': origin,
      };

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      animalId: json['animalId'] ?? '',
      localPath: json['localPath'] ?? '',
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      type: json['type'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? '',
      origin: json['origin'] ?? '',
    );
  }

  VideoModel copyWith({
    String? id,
    String? userId,
    String? animalId,
    String? localPath,
    int? duration,
    String? type,
    DateTime? createdAt,
    String? status,
    String? origin,
  }) {
    return VideoModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      animalId: animalId ?? this.animalId,
      localPath: localPath ?? this.localPath,
      duration: duration ?? this.duration,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      origin: origin ?? this.origin,
    );
  }
}
