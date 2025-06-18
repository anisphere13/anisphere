// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ia_metrics_collector.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IAMetricAdapter extends TypeAdapter<IAMetric> {
  @override
  final int typeId = 101;

  @override
  IAMetric read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IAMetric(
      module: fields[0] as String,
      type: fields[1] as String,
      animalId: fields[2] as String,
      userId: fields[3] as String,
      data: (fields[4] as Map?)?.cast<String, dynamic>(),
      metadata: (fields[5] as Map?)?.cast<String, dynamic>(),
      timestamp: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, IAMetric obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.module)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.animalId)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.data)
      ..writeByte(5)
      ..write(obj.metadata)
      ..writeByte(6)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IAMetricAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
