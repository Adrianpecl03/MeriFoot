// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_position.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerPositionAdapter extends TypeAdapter<PlayerPosition> {
  @override
  final int typeId = 1;

  @override
  PlayerPosition read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PlayerPosition.por;
      case 1:
        return PlayerPosition.ld;
      case 2:
        return PlayerPosition.li;
      case 3:
        return PlayerPosition.dfc;
      case 4:
        return PlayerPosition.mcd;
      case 5:
        return PlayerPosition.mc;
      case 6:
        return PlayerPosition.mco;
      case 7:
        return PlayerPosition.md;
      case 8:
        return PlayerPosition.mi;
      case 9:
        return PlayerPosition.ed;
      case 10:
        return PlayerPosition.ei;
      case 11:
        return PlayerPosition.dc;
      default:
        return PlayerPosition.por;
    }
  }

  @override
  void write(BinaryWriter writer, PlayerPosition obj) {
    switch (obj) {
      case PlayerPosition.por:
        writer.writeByte(0);
        break;
      case PlayerPosition.ld:
        writer.writeByte(1);
        break;
      case PlayerPosition.li:
        writer.writeByte(2);
        break;
      case PlayerPosition.dfc:
        writer.writeByte(3);
        break;
      case PlayerPosition.mcd:
        writer.writeByte(4);
        break;
      case PlayerPosition.mc:
        writer.writeByte(5);
        break;
      case PlayerPosition.mco:
        writer.writeByte(6);
        break;
      case PlayerPosition.md:
        writer.writeByte(7);
        break;
      case PlayerPosition.mi:
        writer.writeByte(8);
        break;
      case PlayerPosition.ed:
        writer.writeByte(9);
        break;
      case PlayerPosition.ei:
        writer.writeByte(10);
        break;
      case PlayerPosition.dc:
        writer.writeByte(11);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerPositionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
