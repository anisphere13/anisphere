// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_service.dart';

class ConsentEntryAdapter extends TypeAdapter<ConsentEntry> {
  @override
  final int typeId = 170;

  @override
  ConsentEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConsentEntry(
      type: fields[0] as String,
      module: fields[1] as String,
      version: fields[2] as String,
      scope: fields[3] as String,
      cguVersion: fields[4] as String,
      timestamp: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ConsentEntry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.module)
      ..writeByte(2)
      ..write(obj.version)
      ..writeByte(3)
      ..write(obj.scope)
      ..writeByte(4)
      ..write(obj.cguVersion)
      ..writeByte(5)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsentEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
