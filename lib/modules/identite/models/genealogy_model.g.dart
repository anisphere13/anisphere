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
      fatherId: fields[1] as String?,
      motherId: fields[2] as String?,
      affixe: fields[3] as String?,
      litterNumber: fields[4] as String?,
      lofName: fields[5] as String?,
      lastUpdate: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, GenealogyModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.animalId)
      ..writeByte(1)
      ..write(obj.fatherId)
      ..writeByte(2)
      ..write(obj.motherId)
      ..writeByte(3)
      ..write(obj.affixe)
      ..writeByte(4)
      ..write(obj.litterNumber)
      ..writeByte(5)
      ..write(obj.lofName)
      ..writeByte(6)
      ..write(obj.lastUpdate);
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
