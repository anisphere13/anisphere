// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_gps_queue.dart';

class GpsPointAdapter extends TypeAdapter<GpsPoint> {
  @override
  final int typeId = 150;

  @override
  GpsPoint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GpsPoint(
      fields[0] as double,
      fields[1] as double,
      timestamp: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GpsPoint obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.lon)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GpsPointAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GpsBatchAdapter extends TypeAdapter<GpsBatch> {
  @override
  final int typeId = 151;

  @override
  GpsBatch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GpsBatch(
      points: (fields[0] as List).cast<GpsPoint>(),
      createdAt: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GpsBatch obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.points)
      ..writeByte(1)
      ..write(obj.createdAt);
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
