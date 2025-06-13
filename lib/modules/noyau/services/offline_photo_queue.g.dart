// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_photo_queue.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotoTaskAdapter extends TypeAdapter<PhotoTask> {
  @override
  final int typeId = 103;

  @override
  PhotoTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhotoTask(
      photo: fields[0] as PhotoModel,
    );
  }

  @override
  void write(BinaryWriter writer, PhotoTask obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.photo);
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
