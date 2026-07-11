import 'player.dart';

class CurrentBench {

  static final List<Player?> players = List.generate(
    15,
    (_) => null,
  );

  static Player? getPlayer(int index) {
    return players[index];
  }

  static void setPlayer(int index, Player? player) {
    players[index] = player;
  }

  static void clear() {
    for (int i = 0; i < players.length; i++) {
      players[i] = null;
    }
  }

}