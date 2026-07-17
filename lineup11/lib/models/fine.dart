import 'package:hive/hive.dart';

part 'fine.g.dart';

@HiveType(typeId: 3)
class Fine extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String playerId;

  @HiveField(2)
  String infringement;

  @HiveField(3)
  double amount;

  @HiveField(4)
  DateTime date;

  @HiveField(5)
  String? notes;

  @HiveField(6)
  bool paid;

  Fine({
    required this.id,
    required this.playerId,
    required this.infringement,
    required this.amount,
    required this.date,
    this.notes,
    this.paid = false,
  });
}