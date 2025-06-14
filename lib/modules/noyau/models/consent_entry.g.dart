// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsentActionAdapter extends TypeAdapter<ConsentAction> {
  @override
  final int typeId = 60;

  @override
  ConsentAction read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ConsentAction.accepted;
      case 1:
        return ConsentAction.declined;
      case 2:
        return ConsentAction.exportRequested;
      case 3:
        return ConsentAction.deletionRequested;
      default:
        return ConsentAction.accepted;
    }
  }

  @override
  void write(BinaryWriter writer, ConsentAction obj) {
    switch (obj) {
      case ConsentAction.accepted:
        writer.writeByte(0);
        break;
      case ConsentAction.declined:
        writer.writeByte(1);
        break;
      case ConsentAction.exportRequested:
        writer.writeByte(2);
        break;
      case ConsentAction.deletionRequested:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsentActionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ConsentEntryAdapter extends TypeAdapter<ConsentEntry> {
  @override
  final int typeId = 61;

  @override
  ConsentEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConsentEntry(
      id: fields[0] as String,
      userId: fields[1] as String,
      action: fields[2] as ConsentAction,
      timestamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ConsentEntry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.action)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsentEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
