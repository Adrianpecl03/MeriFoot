// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerAdapter extends TypeAdapter<Player> {
  @override
  final int typeId = 0;

  @override
  Player read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Player(
      id: fields[0] as String,
      name: fields[1] as String,
      number: fields[2] as int,
      positions: (fields[3] as List).cast<PlayerPosition>(),
      imagePath: fields[4] as String?,
      age: fields[5] as int?,
      height: fields[6] as double?,
      weight: fields[7] as double?,
      dominantFoot: fields[8] as String?,
      notes: fields[9] as String?,
      matchesPlayed: fields[10] as int,
      matchesStarter: fields[11] as int,
      matchesSubstitute: fields[12] as int,
      goals: fields[13] as int,
      assists: fields[14] as int,
      yellowCards: fields[15] as int,
      redCards: fields[16] as int,
      cleanSheets: fields[17] as int,
      goalsConceded: fields[18] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.positions)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.age)
      ..writeByte(6)
      ..write(obj.height)
      ..writeByte(7)
      ..write(obj.weight)
      ..writeByte(8)
      ..write(obj.dominantFoot)
      ..writeByte(9)
      ..write(obj.notes)
      ..writeByte(10)
      ..write(obj.matchesPlayed)
      ..writeByte(11)
      ..write(obj.matchesStarter)
      ..writeByte(12)
      ..write(obj.matchesSubstitute)
      ..writeByte(13)
      ..write(obj.goals)
      ..writeByte(14)
      ..write(obj.assists)
      ..writeByte(15)
      ..write(obj.yellowCards)
      ..writeByte(16)
      ..write(obj.redCards)
      ..writeByte(17)
      ..write(obj.cleanSheets)
      ..writeByte(18)
      ..write(obj.goalsConceded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
