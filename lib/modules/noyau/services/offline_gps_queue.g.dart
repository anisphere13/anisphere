// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_gps_queue.dart';

class GpsBatchAdapter extends TypeAdapter<GpsBatch> {
  @override
  final int typeId = 133;

  @override
  GpsBatch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GpsBatch(
      data: (fields[0] as List).cast<Map<String, dynamic>>(),
      timestamp: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GpsBatch obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GpsBatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
