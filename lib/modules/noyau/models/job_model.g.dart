// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobModelAdapter extends TypeAdapter<JobModel> {
  @override
  final int typeId = 130;

  @override
  JobModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JobModel(
      id: fields[0] as String,
      type: fields[1] as String,
      target: fields[2] as String,
      nextRun: fields[3] as DateTime,
      status: fields[4] as String,
      attempt: fields[5] as int,
      logs: (fields[6] as List).cast<String>(),
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, JobModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.target)
      ..writeByte(3)
      ..write(obj.nextRun)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.attempt)
      ..writeByte(6)
      ..write(obj.logs)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
