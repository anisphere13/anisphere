// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_message_queue.dart';

class QueuedMessageAdapter extends TypeAdapter<QueuedMessage> {
  @override
  final int typeId = 121;

  @override
  QueuedMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QueuedMessage(
      message: fields[0] as MessageModel,
    );
  }

  @override
  void write(BinaryWriter writer, QueuedMessage obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueuedMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
