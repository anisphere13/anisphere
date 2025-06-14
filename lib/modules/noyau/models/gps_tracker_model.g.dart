// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gps_tracker_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GpsTrackerModelAdapter extends TypeAdapter<GpsTrackerModel> {
  @override
  final int typeId = 60;

  @override
  GpsTrackerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GpsTrackerModel(
      timestamp: fields[0] as DateTime,
      latitude: fields[1] as double,
      longitude: fields[2] as double,
      context: fields[3] as String,
      iaTags: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, GpsTrackerModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.context)
      ..writeByte(4)
      ..write(obj.iaTags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GpsTrackerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
