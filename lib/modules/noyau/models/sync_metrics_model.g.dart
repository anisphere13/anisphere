// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_metrics_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SyncMetricsModelAdapter extends TypeAdapter<SyncMetricsModel> {
  @override
  final int typeId = 25;

  @override
  SyncMetricsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SyncMetricsModel(
      operation: fields[0] as String,
      timestamp: fields[1] as DateTime,
      success: fields[2] as bool,
      details: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SyncMetricsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.operation)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.success)
      ..writeByte(3)
      ..write(obj.details);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncMetricsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
