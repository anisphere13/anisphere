// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genealogy_model.dart';

class GenealogyModelAdapter extends TypeAdapter<GenealogyModel> {
  @override
  final int typeId = 42;

  @override
  GenealogyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GenealogyModel(
      animalId: fields[0] as String,
      fatherName: fields[1] as String?,
      motherName: fields[2] as String?,
      affixe: fields[3] as String?,
      litterNumber: fields[4] as String?,
      lofName: fields[5] as String?,
      lastUpdate: fields[6] as DateTime?,
      originCountry: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GenealogyModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.animalId)
      ..writeByte(1)
      ..write(obj.fatherName)
      ..writeByte(2)
      ..write(obj.motherName)
      ..writeByte(3)
      ..write(obj.affixe)
      ..writeByte(4)
      ..write(obj.litterNumber)
      ..writeByte(5)
      ..write(obj.lofName)
      ..writeByte(6)
      ..write(obj.lastUpdate)
      ..writeByte(7)
      ..write(obj.originCountry);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenealogyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
