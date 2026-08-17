// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tactic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TacticAdapter extends TypeAdapter<Tactic> {
  @override
  final int typeId = 5;

  @override
  Tactic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tactic(
      id: fields[0] as String,
      name: fields[1] as String,
      createdAt: fields[2] as DateTime,
      objects: (fields[3] as List).cast<TacticObject>(),
      arrows: (fields[4] as List?)?.cast<TacticArrow>(),
    );
  }

  @override
  void write(BinaryWriter writer, Tactic obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.objects)
      ..writeByte(4)
      ..write(obj.arrows);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TacticAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
