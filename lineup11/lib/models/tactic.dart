import 'package:hive/hive.dart';
import 'tactic_arrow.dart';

import 'tactic_object.dart';

part 'tactic.g.dart';



@HiveType(typeId: 5)
class Tactic extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  DateTime createdAt;

  @HiveField(3)
  List<TacticObject> objects;

  @HiveField(4)
  List<TacticArrow> arrows;

  Tactic({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.objects,
    List<TacticArrow>? arrows,
  }) : arrows = arrows ?? <TacticArrow>[];
}