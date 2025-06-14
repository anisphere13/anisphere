// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsentModelAdapter extends TypeAdapter<ConsentModel> {
  @override
  final int typeId = 26;

  @override
  ConsentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConsentModel(
      id: fields[0] as String,
      type: fields[1] as String,
      module: fields[2] as String,
      acceptedAt: fields[3] as DateTime,
      cguVersion: fields[4] as int,
      scope: (fields[5] as List).cast<String>(),
      revokedAt: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ConsentModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.module)
      ..writeByte(3)
      ..write(obj.acceptedAt)
      ..writeByte(4)
      ..write(obj.cguVersion)
      ..writeByte(5)
      ..write(obj.scope)
      ..writeByte(6)
      ..write(obj.revokedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
