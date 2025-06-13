// Copilot Prompt : Modèle PhotoModel pour AniSphère.
// Stocke les informations d'une photo locale ou synchronisée.
// Compatible Hive et JSON.

library;

import 'package:hive/hive.dart';

part 'photo_model.g.dart';

@HiveType(typeId: 102)
class PhotoModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String localPath;

  @HiveField(2)
  final String? remoteUrl;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final bool uploaded;

  const PhotoModel({
    required this.id,
    required this.localPath,
    this.remoteUrl,
    required this.createdAt,
    this.uploaded = false,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        id: json['id'] ?? '',
        localPath: json['localPath'] ?? '',
        remoteUrl: json['remoteUrl'],
        createdAt:
            DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
        uploaded: json['uploaded'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'localPath': localPath,
        'remoteUrl': remoteUrl,
        'createdAt': createdAt.toIso8601String(),
        'uploaded': uploaded,
      };

  PhotoModel copyWith({
    String? id,
    String? localPath,
    String? remoteUrl,
    DateTime? createdAt,
    bool? uploaded,
  }) {
    return PhotoModel(
      id: id ?? this.id,
      localPath: localPath ?? this.localPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      createdAt: createdAt ?? this.createdAt,
      uploaded: uploaded ?? this.uploaded,
    );
  }
}
