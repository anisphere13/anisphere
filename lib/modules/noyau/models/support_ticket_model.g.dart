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
      type: fields[2] as SupportTicketType,
      message: fields[3] as String,
      status: fields[4] as SupportTicketStatus,
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

class SupportTicketTypeAdapter extends TypeAdapter<SupportTicketType> {
  @override
  final int typeId = 22;

  @override
  SupportTicketType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SupportTicketType.bug;
      case 1:
        return SupportTicketType.idee;
      case 2:
        return SupportTicketType.contact;
      default:
        return SupportTicketType.bug;
    }
  }

  @override
  void write(BinaryWriter writer, SupportTicketType obj) {
    switch (obj) {
      case SupportTicketType.bug:
        writer.writeByte(0);
        break;
      case SupportTicketType.idee:
        writer.writeByte(1);
        break;
      case SupportTicketType.contact:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportTicketTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SupportTicketStatusAdapter extends TypeAdapter<SupportTicketStatus> {
  @override
  final int typeId = 23;

  @override
  SupportTicketStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SupportTicketStatus.brouillon;
      case 1:
        return SupportTicketStatus.enCours;
      case 2:
        return SupportTicketStatus.resolu;
      default:
        return SupportTicketStatus.brouillon;
    }
  }

  @override
  void write(BinaryWriter writer, SupportTicketStatus obj) {
    switch (obj) {
      case SupportTicketStatus.brouillon:
        writer.writeByte(0);
        break;
      case SupportTicketStatus.enCours:
        writer.writeByte(1);
        break;
      case SupportTicketStatus.resolu:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportTicketStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
