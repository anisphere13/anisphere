// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_feedback_service.dart';

class NotificationFeedbackAdapter extends TypeAdapter<NotificationFeedback> {
  @override
  final int typeId = 102;

  @override
  NotificationFeedback read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationFeedback(
      id: fields[0] as String,
      notificationId: fields[1] as String,
      positive: fields[2] as bool,
      timestamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationFeedback obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.notificationId)
      ..writeByte(2)
      ..write(obj.positive)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationFeedbackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
