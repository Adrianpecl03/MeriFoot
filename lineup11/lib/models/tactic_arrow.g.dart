// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tactic_arrow.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TacticArrowAdapter extends TypeAdapter<TacticArrow> {
  @override
  final int typeId = 6;

  @override
  TacticArrow read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TacticArrow(
      id: fields[0] as String,
      startX: fields[1] as double,
      startY: fields[2] as double,
      endX: fields[3] as double,
      endY: fields[4] as double,
      color: fields[5] as String,
      width: fields[6] as double,
      dashed: fields[7] as bool,
      curved: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TacticArrow obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startX)
      ..writeByte(2)
      ..write(obj.startY)
      ..writeByte(3)
      ..write(obj.endX)
      ..writeByte(4)
      ..write(obj.endY)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.width)
      ..writeByte(7)
      ..write(obj.dashed)
      ..writeByte(8)
      ..write(obj.curved);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TacticArrowAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
