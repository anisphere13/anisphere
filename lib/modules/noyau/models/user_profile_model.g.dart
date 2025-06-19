// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

class UserProfileModelAdapter extends TypeAdapter<UserProfileModel> {
  @override
  final int typeId = 52;

  @override
  UserProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfileModel(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      phone: fields[3] as String,
      profilePicture: fields[4] as String,
      profession: fields[5] as String,
      ownedSpecies: (fields[6] as Map).cast<String, bool>(),
      ownedAnimals: (fields[7] as List).cast<String>(),
      preferences: (fields[8] as Map).cast<String, dynamic>(),
      moduleRoles: (fields[9] as Map).cast<String, dynamic>(),
      createdAt: fields[10] as DateTime,
      updatedAt: fields[11] as DateTime,
      activeModules: (fields[12] as List).cast<String>(),
      role: fields[13] as String,
      iaPremium: fields[14] as bool,
      lastIASync: fields[15] as DateTime?,
      iaTrained: fields[16] as bool,
      syncedAt: fields[17] as DateTime?,
      langue: fields[18] as String?,
      lastName: fields[19] as String,
      firstName: fields[20] as String,
      address: fields[21] as String,
      birthDate: fields[22] as DateTime?,
      birthPlace: fields[23] as String,
      unit: fields[24] as String,
      company: fields[25] as String,
      group: fields[26] as String,
      nigend: fields[27] as String,
      proValidated: fields[28] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfileModel obj) {
    writer
      ..writeByte(29)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.profilePicture)
      ..writeByte(5)
      ..write(obj.profession)
      ..writeByte(6)
      ..write(obj.ownedSpecies)
      ..writeByte(7)
      ..write(obj.ownedAnimals)
      ..writeByte(8)
      ..write(obj.preferences)
      ..writeByte(9)
      ..write(obj.moduleRoles)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
      ..write(obj.activeModules)
      ..writeByte(13)
      ..write(obj.role)
      ..writeByte(14)
      ..write(obj.iaPremium)
      ..writeByte(15)
      ..write(obj.lastIASync)
      ..writeByte(16)
      ..write(obj.iaTrained)
      ..writeByte(17)
      ..write(obj.syncedAt)
      ..writeByte(18)
      ..write(obj.langue)
      ..writeByte(19)
      ..write(obj.lastName)
      ..writeByte(20)
      ..write(obj.firstName)
      ..writeByte(21)
      ..write(obj.address)
      ..writeByte(22)
      ..write(obj.birthDate)
      ..writeByte(23)
      ..write(obj.birthPlace)
      ..writeByte(24)
      ..write(obj.unit)
      ..writeByte(25)
      ..write(obj.company)
      ..writeByte(26)
      ..write(obj.group)
      ..writeByte(27)
      ..write(obj.nigend)
      ..writeByte(28)
      ..write(obj.proValidated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
