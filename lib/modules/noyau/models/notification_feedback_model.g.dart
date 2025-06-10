// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_feedback_model.dart';

class NotificationFeedbackModelAdapter extends TypeAdapter<NotificationFeedbackModel> {
  @override
  final int typeId = 24;

  @override
  NotificationFeedbackModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationFeedbackModel(
      notificationId: fields[0] as String,
      userId: fields[1] as String,
      openedAt: fields[2] as DateTime,
      reaction: fields[3] as String,
      module: fields[4] as String,
      type: fields[5] as String,
      createdAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationFeedbackModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.notificationId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.openedAt)
      ..writeByte(3)
      ..write(obj.reaction)
      ..writeByte(4)
      ..write(obj.module)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationFeedbackModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
