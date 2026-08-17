// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tactic_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TacticObjectAdapter extends TypeAdapter<TacticObject> {
  @override
  final int typeId = 4;

  @override
  TacticObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++)
        reader.readByte(): reader.read(),
    };

    return TacticObject(
      id: fields[0] as String,
      type: fields[1] as String,
      x: fields[2] as double,
      y: fields[3] as double,
      rotation: (fields[4] as double?) ?? 0,
      color: (fields[5] as String?) ?? "red",
      label: fields[6] as String?,
      size: (fields[7] as double?) ?? 1,
      locked: (fields[8] as bool?) ?? false,
      zIndex: (fields[9] as int?) ?? 0,
    );
  }

  @override
  void write(BinaryWriter writer, TacticObject obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.x)
      ..writeByte(3)
      ..write(obj.y)
      ..writeByte(4)
      ..write(obj.rotation)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.label)
      ..writeByte(7)
      ..write(obj.size)
      ..writeByte(8)
      ..write(obj.locked)
      ..writeByte(9)
      ..write(obj.zIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TacticObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
