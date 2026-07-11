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
        return PlayerPosition.gk;
      case 1:
        return PlayerPosition.lb;
      case 2:
        return PlayerPosition.cb;
      case 3:
        return PlayerPosition.rb;
      case 4:
        return PlayerPosition.lwb;
      case 5:
        return PlayerPosition.rwb;
      case 6:
        return PlayerPosition.cdm;
      case 7:
        return PlayerPosition.lcm;
      case 8:
        return PlayerPosition.cm;
      case 9:
        return PlayerPosition.rcm;
      case 10:
        return PlayerPosition.cam;
      case 11:
        return PlayerPosition.lm;
      case 12:
        return PlayerPosition.rm;
      case 13:
        return PlayerPosition.lw;
      case 14:
        return PlayerPosition.rw;
      case 15:
        return PlayerPosition.st;
      case 16:
        return PlayerPosition.ls;
      case 17:
        return PlayerPosition.rs;
      default:
        return PlayerPosition.gk;
    }
  }

  @override
  void write(BinaryWriter writer, PlayerPosition obj) {
    switch (obj) {
      case PlayerPosition.gk:
        writer.writeByte(0);
        break;
      case PlayerPosition.lb:
        writer.writeByte(1);
        break;
      case PlayerPosition.cb:
        writer.writeByte(2);
        break;
      case PlayerPosition.rb:
        writer.writeByte(3);
        break;
      case PlayerPosition.lwb:
        writer.writeByte(4);
        break;
      case PlayerPosition.rwb:
        writer.writeByte(5);
        break;
      case PlayerPosition.cdm:
        writer.writeByte(6);
        break;
      case PlayerPosition.lcm:
        writer.writeByte(7);
        break;
      case PlayerPosition.cm:
        writer.writeByte(8);
        break;
      case PlayerPosition.rcm:
        writer.writeByte(9);
        break;
      case PlayerPosition.cam:
        writer.writeByte(10);
        break;
      case PlayerPosition.lm:
        writer.writeByte(11);
        break;
      case PlayerPosition.rm:
        writer.writeByte(12);
        break;
      case PlayerPosition.lw:
        writer.writeByte(13);
        break;
      case PlayerPosition.rw:
        writer.writeByte(14);
        break;
      case PlayerPosition.st:
        writer.writeByte(15);
        break;
      case PlayerPosition.ls:
        writer.writeByte(16);
        break;
      case PlayerPosition.rs:
        writer.writeByte(17);
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
