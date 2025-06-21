// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IdentityModelAdapter extends TypeAdapter<IdentityModel> {
  @override
  final int typeId = 40;

  @override
  IdentityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IdentityModel(
      animalId: fields[0] as String,
      microchipNumber: fields[1] as String?,
      photoUrl: fields[2] as String?,
      status: fields[3] as String?,
      legalStatus: fields[4] as String?,
      verifiedByIA: fields[5] as bool,
      history: (fields[6] as List).cast<IdentityChange>(),
      hasPublicQR: fields[7] as bool,
      lastUpdate: fields[8] as DateTime?,
      aiScore: fields[9] as double,
      verifiedBreed: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, IdentityModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.animalId)
      ..writeByte(1)
      ..write(obj.microchipNumber)
      ..writeByte(2)
      ..write(obj.photoUrl)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.legalStatus)
      ..writeByte(5)
      ..write(obj.verifiedByIA)
      ..writeByte(6)
      ..write(obj.history)
      ..writeByte(7)
      ..write(obj.hasPublicQR)
      ..writeByte(8)
      ..write(obj.lastUpdate)
      ..writeByte(9)
      ..write(obj.aiScore)
      ..writeByte(10)
      ..write(obj.verifiedBreed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdentityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IdentityChangeAdapter extends TypeAdapter<IdentityChange> {
  @override
  final int typeId = 41;

  @override
  IdentityChange read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IdentityChange(
      field: fields[0] as String,
      oldValue: fields[1] as String,
      newValue: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, IdentityChange obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.field)
      ..writeByte(1)
      ..write(obj.oldValue)
      ..writeByte(2)
      ..write(obj.newValue)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdentityChangeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
