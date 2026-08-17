import 'package:hive/hive.dart';

part 'player_position.g.dart';

@HiveType(typeId: 1)
enum PlayerPosition {

  @HiveField(0)
  por,

  @HiveField(1)
  ld,

  @HiveField(2)
  li,

  @HiveField(3)
  dfc,

  @HiveField(4)
  mcd,

  @HiveField(5)
  mc,

  @HiveField(6)
  mco,

  @HiveField(7)
  md,

  @HiveField(8)
  mi,

  @HiveField(9)
  ed,

  @HiveField(10)
  ei,

  @HiveField(11)
  dc,
}

extension PlayerPositionExtension on PlayerPosition {
  String get label {
    switch (this) {
      case PlayerPosition.por:
        return "POR";
      case PlayerPosition.ld:
        return "LD";
      case PlayerPosition.li:
        return "LI";
      case PlayerPosition.dfc:
        return "DFC";
      case PlayerPosition.mcd:
        return "MCD";
      case PlayerPosition.mc:
        return "MC";
      case PlayerPosition.mco:
        return "MCO";
      case PlayerPosition.md:
        return "MD";
      case PlayerPosition.mi:
        return "MI";
      case PlayerPosition.ed:
        return "ED";
      case PlayerPosition.ei:
        return "EI";
      case PlayerPosition.dc:
        return "DC";
    }
  }
}