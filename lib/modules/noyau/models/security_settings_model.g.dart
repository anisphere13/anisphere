// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SecuritySettingsModelAdapter extends TypeAdapter<SecuritySettingsModel> {
  @override
  final int typeId = 70;

  @override
  SecuritySettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SecuritySettingsModel(
      biometricEnabled: fields[0] as bool,
      encryptedPin: fields[1] as String?,
      protectedModules: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SecuritySettingsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.biometricEnabled)
      ..writeByte(1)
      ..write(obj.encryptedPin)
      ..writeByte(2)
      ..write(obj.protectedModules);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SecuritySettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
