import 'package:flutter/material.dart';

import '../../models/current_lineup.dart';
import '../../models/player.dart';
import '../../services/player_service.dart';
import '../../utils/position_mapper.dart';
import '../../widgets/player_options_dialog.dart';
import '../../widgets/player_selector_dialog.dart';
import '../../widgets/player_slot.dart';
import 'field_painter.dart';
import 'formations.dart';

class FootballField extends StatefulWidget {
  final String formation;

  const FootballField({
    super.key,
    required this.formation,
  });

  @override
  State<FootballField> createState() => _FootballFieldState();
}

class _FootballFieldState extends State<FootballField> {

  Future<void> _positionPressed(String positionId) async {

    final current =
        CurrentLineup.getPosition(positionId);

    if (current.player == null) {

      await _selectPlayer(positionId);

      return;

    }

    final option = await showDialog<PlayerOption>(

      context: context,

      builder: (_) => const PlayerOptionsDialog(),

    );

    if (option == null) return;

    switch (option) {

      case PlayerOption.change:

        await _selectPlayer(positionId);

        break;

      case PlayerOption.remove:

        setState(() {

          current.player = null;

        });

        break;

    }

  }

  Future<void> _selectPlayer(String positionId) async {

    final allowed =
        PositionMapper.allowedPositions(positionId);

    final usedPlayers = CurrentLineup.players.values
        .where((e) => e.player != null)
        .map((e) => e.player!.id)
        .toSet();

    final current =
        CurrentLineup.getPosition(positionId);

    if (current.player != null) {

      usedPlayers.remove(current.player!.id);

    }

    final players =
        PlayerService.getPlayers().where((player) {

      if (usedPlayers.contains(player.id)) {

        return false;

      }

      return player.positions.any(
        (p) => allowed.contains(p),
      );

    }).toList();

    final Player? player =
        await showDialog<Player>(

      context: context,

      builder: (_) => PlayerSelectorDialog(
        players: players,
      ),

    );

    if (player == null) return;

    setState(() {

      current.player = player;

    });

  }

  @override
  Widget build(BuildContext context) {

    final positions =
        Formations.data[widget.formation] ??
            Formations.data["4-3-3"]!;

    return AspectRatio(

      aspectRatio: 0.62,

      child: Container(

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(24),

          gradient: const LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [

              Color(0xFF1E7A3A),

              Color(0xFF155E2A),

            ],

          ),

          border: Border.all(
            color: Colors.white70,
            width: 2,
          ),

        ),

        child: Stack(

          children: [

            Positioned.fill(

              child: CustomPaint(
                painter: FieldPainter(),
              ),

            ),

            ...positions.map((position) {

              final lineupPlayer =
                  CurrentLineup.getPosition(position.id);

              return Align(

                alignment: position.alignment,

                child: PlayerSlot(

                  player: lineupPlayer.player,

                  onTap: () {

                    _positionPressed(position.id);

                  },

                ),

              );

            }),

          ],

        ),

      ),

    );

  }

}