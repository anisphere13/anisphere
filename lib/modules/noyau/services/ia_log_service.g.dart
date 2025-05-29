// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ia_log_service.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IALogEntryAdapter extends TypeAdapter<IALogEntry> {
  @override
  final int typeId = 10;

  @override
  IALogEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IALogEntry(
      timestamp: fields[0] as DateTime,
      type: fields[1] as String,
      message: fields[2] as String,
      module: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, IALogEntry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.module);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IALogEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
