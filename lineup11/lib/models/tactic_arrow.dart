import 'package:hive/hive.dart';

part 'tactic_arrow.g.dart';

@HiveType(typeId: 6)
class TacticArrow extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  double startX;

  @HiveField(2)
  double startY;

  @HiveField(3)
  double endX;

  @HiveField(4)
  double endY;

  @HiveField(5)
  String color;

  @HiveField(6)
  double width;

  @HiveField(7)
  bool dashed;

  @HiveField(8)
  bool curved;

  TacticArrow({
    required this.id,
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    this.color = "yellow",
    this.width = 4,
    this.dashed = false,
    this.curved = false,
  });

  TacticArrow copy() {
    return TacticArrow(
      id: id,
      startX: startX,
      startY: startY,
      endX: endX,
      endY: endY,
      color: color,
      width: width,
      dashed: dashed,
      curved: curved,
    );
  }
}