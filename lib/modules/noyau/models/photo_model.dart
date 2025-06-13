library;

import 'package:hive/hive.dart';

part 'photo_model.g.dart';

@HiveType(typeId: 50)
class PhotoModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String animalId;

  @HiveField(3)
  final String localPath;

  @HiveField(4)
  final DateTime createdAt;

  const PhotoModel({
    required this.id,
    required this.userId,
    required this.animalId,
    required this.localPath,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'animalId': animalId,
        'localPath': localPath,
        'createdAt': createdAt.toIso8601String(),
      };

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      animalId: json['animalId'] ?? '',
      localPath: json['localPath'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  PhotoModel copyWith({
    String? id,
    String? userId,
    String? animalId,
    String? localPath,
    DateTime? createdAt,
  }) {
    return PhotoModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      animalId: animalId ?? this.animalId,
      localPath: localPath ?? this.localPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
