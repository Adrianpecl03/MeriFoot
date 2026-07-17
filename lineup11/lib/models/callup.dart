import 'package:hive/hive.dart';

part 'callup.g.dart';

@HiveType(typeId: 2)
class Callup extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String opponent;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  String time;

  @HiveField(5)
  String field;

  @HiveField(6)
  List<String> playerIds;

  Callup({
    required this.id,
    required this.title,
    required this.opponent,
    required this.date,
    required this.time,
    required this.field,
    required this.playerIds,
  });

}