// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_scheduler_settings.dart';

class JobSchedulerSettingsAdapter extends TypeAdapter<JobSchedulerSettings> {
  @override
  final int typeId = 72;

  @override
  JobSchedulerSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JobSchedulerSettings(
      autoJobsEnabled: fields[0] as bool,
      enableLogs: fields[1] as bool,
      autoPurgeDays: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, JobSchedulerSettings obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.autoJobsEnabled)
      ..writeByte(1)
      ..write(obj.enableLogs)
      ..writeByte(2)
      ..write(obj.autoPurgeDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobSchedulerSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
