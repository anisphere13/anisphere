// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SupportModelAdapter extends TypeAdapter<SupportModel> {
  @override
  final int typeId = 20;

  @override
  SupportModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SupportModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      type: fields[2] as String,
      message: fields[3] as String,
      status: fields[4] as String,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
      attachments: (fields[7] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SupportModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.attachments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
