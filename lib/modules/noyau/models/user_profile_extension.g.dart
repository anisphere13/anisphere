// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_extension.dart';

class UserProfileExtensionAdapter extends TypeAdapter<UserProfileExtension> {
  @override
  final int typeId = 92;

  @override
  UserProfileExtension read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfileExtension(
      premiumTrialUntil: fields[0] as DateTime?,
      hasUsedPremiumTrial: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfileExtension obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.premiumTrialUntil)
      ..writeByte(1)
      ..write(obj.hasUsedPremiumTrial);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileExtensionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
