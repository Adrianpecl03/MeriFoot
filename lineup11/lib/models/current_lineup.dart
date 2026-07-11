import 'lineup_player.dart';

class CurrentLineup {

  static final Map<String, LineupPlayer> players = {};

  static LineupPlayer getPosition(String positionId) {

    if (!players.containsKey(positionId)) {

      players[positionId] = LineupPlayer(
        positionId: positionId,
      );

    }

    return players[positionId]!;

  }

  static void clear() {

    players.clear();

  }

}