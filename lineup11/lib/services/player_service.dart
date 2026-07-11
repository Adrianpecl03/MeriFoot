import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../models/player.dart';
import '../models/player_position.dart';

class PlayerService {

  static final Box<Player> _playersBox =
      Hive.box<Player>("players");

  static const Uuid _uuid = Uuid();

  static List<Player> getPlayers() {
    return _playersBox.values.toList();
  }

  static Future<void> deletePlayer(String id) async {
    final box = Hive.box<Player>("players");

    final key = box.keys.firstWhere(
      (k) => box.get(k)!.id == id,
    );

    await box.delete(key);
  }

  static Future<void> updatePlayer(Player player) async {
    await player.save();
  }
  static Player? getPlayer(String id) {

    try {

      return _playersBox.values.firstWhere(
        (player) => player.id == id,
      );

    } catch (_) {

      return null;

    }

  }

  static Future<void> addPlayer({

    required String name,

    required int number,

    required List<PlayerPosition> positions,

    String? imagePath,

    int? age,

    double? height,

    double? weight,

    String? dominantFoot,

    String? notes,

  }) async {

    final player = Player(

      id: _uuid.v4(),

      name: name,

      number: number,

      positions: positions,

      imagePath: imagePath,

      age: age,

      height: height,

      weight: weight,

      dominantFoot: dominantFoot,

      notes: notes,

    );

    await _playersBox.put(
      player.id,
      player,
    );

  }

  static Future<void> deleteAllPlayers() async {

    await _playersBox.clear();

  }

}