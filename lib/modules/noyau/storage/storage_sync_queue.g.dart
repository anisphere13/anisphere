// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_sync_queue.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StorageSyncTaskAdapter extends TypeAdapter<StorageSyncTask> {
  @override
  final int typeId = 122;

  @override
  StorageSyncTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StorageSyncTask(
      id: fields[0] as String,
      targetService: fields[1] as String,
      filePath: fields[2] as String,
      priority: fields[3] as int,
      createdAt: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, StorageSyncTask obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.targetService)
      ..writeByte(2)
      ..write(obj.filePath)
      ..writeByte(3)
      ..write(obj.priority)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StorageSyncTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
