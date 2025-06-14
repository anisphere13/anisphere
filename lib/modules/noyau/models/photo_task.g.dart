// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotoTaskAdapter extends TypeAdapter<PhotoTask> {
  @override
  final int typeId = 6;

  @override
  PhotoTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhotoTask(
      animalId: fields[0] as String,
      userId: fields[1] as String,
      uploaded: fields[2] as bool,
      remoteUrl: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PhotoTask obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.animalId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.uploaded)
      ..writeByte(3)
      ..write(obj.remoteUrl);
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
