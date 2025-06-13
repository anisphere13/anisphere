library;
// TODO: ajouter test

import 'package:hive/hive.dart';

part 'photo_task.g.dart';

@HiveType(typeId: 6)
class PhotoTask {
  @HiveField(0)
  final String animalId;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final bool uploaded;

  @HiveField(3)
  final String remoteUrl;

  const PhotoTask({
    required this.animalId,
    required this.userId,
    this.uploaded = false,
    this.remoteUrl = '',
  });

  PhotoTask copyWith({
    String? animalId,
    String? userId,
    bool? uploaded,
    String? remoteUrl,
  }) {
    return PhotoTask(
      animalId: animalId ?? this.animalId,
      userId: userId ?? this.userId,
      uploaded: uploaded ?? this.uploaded,
      remoteUrl: remoteUrl ?? this.remoteUrl,
    );
  }
}
