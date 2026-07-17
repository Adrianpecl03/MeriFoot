// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callup.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CallupAdapter extends TypeAdapter<Callup> {
  @override
  final int typeId = 2;

  @override
  Callup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Callup(
      id: fields[0] as String,
      title: fields[1] as String,
      opponent: fields[2] as String,
      date: fields[3] as DateTime,
      time: fields[4] as String,
      field: fields[5] as String,
      playerIds: (fields[6] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Callup obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.opponent)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.field)
      ..writeByte(6)
      ..write(obj.playerIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CallupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
