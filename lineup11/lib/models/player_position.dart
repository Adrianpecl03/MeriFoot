import 'package:hive/hive.dart';

part 'player_position.g.dart';

@HiveType(typeId: 1)
enum PlayerPosition {

  @HiveField(0)
  gk,

  @HiveField(1)
  lb,

  @HiveField(2)
  cb,

  @HiveField(3)
  rb,

  @HiveField(4)
  lwb,

  @HiveField(5)
  rwb,

  @HiveField(6)
  cdm,

  @HiveField(7)
  lcm,

  @HiveField(8)
  cm,

  @HiveField(9)
  rcm,

  @HiveField(10)
  cam,

  @HiveField(11)
  lm,

  @HiveField(12)
  rm,

  @HiveField(13)
  lw,

  @HiveField(14)
  rw,

  @HiveField(15)
  st,

  @HiveField(16)
  ls,

  @HiveField(17)
  rs,
}