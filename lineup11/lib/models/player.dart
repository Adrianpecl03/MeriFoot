import 'package:hive/hive.dart';

import 'player_position.dart';

part 'player.g.dart';

@HiveType(typeId: 0)
class Player extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int number;

  @HiveField(3)
  List<PlayerPosition> positions;

  @HiveField(4)
  String? imagePath;

  @HiveField(5)
  int? age;

  @HiveField(6)
  double? height;

  @HiveField(7)
  double? weight;

  @HiveField(8)
  String? dominantFoot;

  @HiveField(9)
  String? notes;

  @HiveField(10)
  int matchesPlayed;

  @HiveField(11)
  int matchesStarter;

  @HiveField(12)
  int matchesSubstitute;

  @HiveField(13)
  int goals;

  @HiveField(14)
  int assists;

  @HiveField(15)
  int yellowCards;

  @HiveField(16)
  int redCards;

  @HiveField(17)
  int cleanSheets;

  @HiveField(18)
  int goalsConceded;

  Player({
    required this.id,
    required this.name,
    required this.number,
    required this.positions,
    this.imagePath,
    this.age,
    this.height,
    this.weight,
    this.dominantFoot,
    this.notes,
    this.matchesPlayed = 0,
    this.matchesStarter = 0,
    this.matchesSubstitute = 0,
    this.goals = 0,
    this.assists = 0,
    this.yellowCards = 0,
    this.redCards = 0,
    this.cleanSheets = 0,
    this.goalsConceded = 0,
  });

}