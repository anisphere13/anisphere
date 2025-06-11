// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageModelAdapter extends TypeAdapter<MessageModel> {
  @override
  final int typeId = 70;

  @override
  MessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageModel(
      id: fields[0] as String,
      conversationId: fields[1] as String,
      senderId: fields[2] as String,
      receiverId: fields[3] as String,
      content: fields[4] as String,
      timestamp: fields[5] as DateTime,
      moduleContext: fields[6] as String,
      priority: fields[7] as int,
      status: fields[8] as String,
      sent: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MessageModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.conversationId)
      ..writeByte(2)
      ..write(obj.senderId)
      ..writeByte(3)
      ..write(obj.receiverId)
      ..writeByte(4)
      ..write(obj.content)
      ..writeByte(5)
      ..write(obj.timestamp)
      ..writeByte(6)
      ..write(obj.moduleContext)
      ..writeByte(7)
      ..write(obj.priority)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.sent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
