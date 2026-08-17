import 'package:hive/hive.dart';

part 'tactic_object.g.dart';

@HiveType(typeId: 4)
class TacticObject extends HiveObject {
  @HiveField(0)
  String id;

  /// player
  /// opponent
  /// ball
  /// cone
  /// goal
  /// arrow
  /// drawing
  @HiveField(1)
  String type;

  /// Posición horizontal (0..1)
  @HiveField(2)
  double x;

  /// Posición vertical (0..1)
  @HiveField(3)
  double y;

  /// Rotación en grados
  @HiveField(4)
  double rotation;

  /// Color
  @HiveField(5)
  String color;

  /// Texto (número del jugador)
  @HiveField(6)
  String? label;

  /// Escala del objeto
  @HiveField(7)
  double size;

  /// Bloqueado
  @HiveField(8)
  bool locked;

  /// Orden de dibujo
  @HiveField(9)
  int zIndex;

  TacticObject({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    this.rotation = 0,
    this.color = "red",
    this.label,
    this.size = 1,
    this.locked = false,
    this.zIndex = 0,
  });

  TacticObject copy() {
    return TacticObject(
      id: id,
      type: type,
      x: x,
      y: y,
      rotation: rotation,
      color: color,
      label: label,
      size: size,
      locked: locked,
      zIndex: zIndex,
    );
  }
}