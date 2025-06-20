// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_sync_queue.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SyncTaskAdapter extends TypeAdapter<SyncTask> {
  @override
  final int typeId = 100;

  @override
  SyncTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SyncTask(
      type: fields[0] as String,
      data: (fields[1] as Map?)?.cast<String, dynamic>(),
      timestamp: fields[2] as DateTime?,
      id: fields[3] as String?,
      filePath: fields[4] as String?,
      priority: fields[5] as int? ?? 0,
    );
  }

  @override
  void write(BinaryWriter writer, SyncTask obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.filePath)
      ..writeByte(5)
      ..write(obj.priority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
