// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

class EventModelAdapter extends TypeAdapter<EventModel> {
  @override
  final int typeId = 160;

  @override
  EventModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventModel(
      type: fields[0] as String,
      payload: (fields[1] as Map).cast<String, dynamic>(),
      timestamp: fields[2] as DateTime?,
      sender: fields[3] as String,
      scope: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EventModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.payload)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.sender)
      ..writeByte(4)
      ..write(obj.scope);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
