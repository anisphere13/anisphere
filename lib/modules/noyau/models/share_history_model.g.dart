// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShareHistoryModelAdapter extends TypeAdapter<ShareHistoryModel> {
  @override
  final int typeId = 30;

  @override
  ShareHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShareHistoryModel(
      mode: fields[0] as String,
      date: fields[1] as DateTime,
      success: fields[2] as bool,
      feedback: fields[3] as String,
      cost: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ShareHistoryModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.mode)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.success)
      ..writeByte(3)
      ..write(obj.feedback)
      ..writeByte(4)
      ..write(obj.cost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShareHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
