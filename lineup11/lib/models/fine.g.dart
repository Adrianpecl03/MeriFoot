// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FineAdapter extends TypeAdapter<Fine> {
  @override
  final int typeId = 3;

  @override
  Fine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Fine(
      id: fields[0] as String,
      playerId: fields[1] as String,
      infringement: fields[2] as String,
      amount: fields[3] as double,
      date: fields[4] as DateTime,
      notes: fields[5] as String?,
      paid: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Fine obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.playerId)
      ..writeByte(2)
      ..write(obj.infringement)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.notes)
      ..writeByte(6)
      ..write(obj.paid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
