// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_queue.dart';

class QueuedEventAdapter extends TypeAdapter<QueuedEvent> {
  @override
  final int typeId = 161;

  @override
  QueuedEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QueuedEvent(
      event: fields[0] as EventModel,
      timestamp: fields[1] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, QueuedEvent obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.event)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueuedEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
