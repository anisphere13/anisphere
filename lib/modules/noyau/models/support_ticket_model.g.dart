// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_ticket_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SupportTicketModelAdapter extends TypeAdapter<SupportTicketModel> {
  @override
  final int typeId = 21;

  @override
  SupportTicketModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SupportTicketModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      type: fields[2] as String,
      message: fields[3] as String,
      status: fields[4] as String,
      logs: fields[5] as String,
      aiResponse: fields[6] as String,
      adminNote: fields[7] as String,
      createdAt: fields[8] as DateTime,
      updatedAt: fields[9] as DateTime,
      moduleName: fields[10] as String,
      attachments: (fields[11] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SupportTicketModel obj) {
    writer
      ..writeByte(12)
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
      ..write(obj.logs)
      ..writeByte(6)
      ..write(obj.aiResponse)
      ..writeByte(7)
      ..write(obj.adminNote)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.moduleName)
      ..writeByte(11)
      ..write(obj.attachments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportTicketModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
