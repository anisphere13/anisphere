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
      name: fields[0] as String,
      value: fields[1] as dynamic,
      timestamp: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, IAMetric obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
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
