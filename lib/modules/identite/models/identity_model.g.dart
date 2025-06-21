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
      photoTimeline: (fields[11] as List).cast<String>(),
      litterNumber: fields[12] as String?,
      lofNumber: fields[13] as String?,
      originCountry: fields[14] as String?,
      alias: fields[15] as String?,
      breederName: fields[16] as String?,
      breederAddress: fields[17] as String?,
      breederSiret: fields[18] as String?,
      breederEmail: fields[19] as String?,
      breederWebsite: fields[20] as String?,
      breederPhone: fields[21] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, IdentityModel obj) {
    writer
      ..writeByte(22)
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
      ..write(obj.verifiedBreed)
      ..writeByte(11)
      ..write(obj.photoTimeline)
      ..writeByte(12)
      ..write(obj.litterNumber)
      ..writeByte(13)
      ..write(obj.lofNumber)
      ..writeByte(14)
      ..write(obj.originCountry)
      ..writeByte(15)
      ..write(obj.alias)
      ..writeByte(16)
      ..write(obj.breederName)
      ..writeByte(17)
      ..write(obj.breederAddress)
      ..writeByte(18)
      ..write(obj.breederSiret)
      ..writeByte(19)
      ..write(obj.breederEmail)
      ..writeByte(20)
      ..write(obj.breederWebsite)
      ..writeByte(21)
      ..write(obj.breederPhone);
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
