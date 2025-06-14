// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_photo_queue.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QueuedPhotoAdapter extends TypeAdapter<QueuedPhoto> {
  @override
  final int typeId = 131;

  @override
  QueuedPhoto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QueuedPhoto(
      photo: fields[0] as PhotoModel,
      timestamp: fields[1] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, QueuedPhoto obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.photo)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueuedPhotoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PhotoTaskAdapter extends TypeAdapter<PhotoTask> {
  @override
  final int typeId = 132;

  @override
  PhotoTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhotoTask(
      photo: fields[0] as PhotoModel,
      animalId: fields[1] as String,
      userId: fields[2] as String,
      uploaded: fields[3] as bool,
      remoteUrl: fields[4] as String,
      timestamp: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, PhotoTask obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.photo)
      ..writeByte(1)
      ..write(obj.animalId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.uploaded)
      ..writeByte(4)
      ..write(obj.remoteUrl)
      ..writeByte(5)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
