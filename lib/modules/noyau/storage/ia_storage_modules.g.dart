// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ia_storage_modules.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IAMetricsAdapter extends TypeAdapter<IAMetrics> {
  @override
  final int typeId = 60;

  @override
  IAMetrics read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IAMetrics(
      key: fields[0] as String,
      data: (fields[1] as Map).cast<String, dynamic>(),
      timestamp: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, IAMetrics obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IAMetricsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SyncTaskAdapter extends TypeAdapter<SyncTask> {
  @override
  final int typeId = 61;

  @override
  SyncTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SyncTask(
      id: fields[0] as String,
      module: fields[1] as String,
      payload: (fields[2] as Map).cast<String, dynamic>(),
      createdAt: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, SyncTask obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.module)
      ..writeByte(2)
      ..write(obj.payload)
      ..writeByte(3)
      ..write(obj.createdAt);
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
