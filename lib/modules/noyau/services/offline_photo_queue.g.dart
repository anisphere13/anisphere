// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_photo_queue.dart';

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
      timestamp: fields[1] as DateTime,
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
