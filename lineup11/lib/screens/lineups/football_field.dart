import 'package:flutter/material.dart';

import '../../models/current_lineup.dart';
import '../../models/player.dart';
import '../../services/player_service.dart';
import '../../utils/position_mapper.dart';
import '../../widgets/player_options_dialog.dart';
import '../../widgets/player_selector_dialog.dart';
import '../../widgets/player_slot.dart';
import 'field_painter.dart';
import 'field_position.dart';
import 'formations.dart';

class FootballField extends StatefulWidget {
  final String formation;
  final String footballType;

  const FootballField({
    super.key,
    required this.formation,
    required this.footballType,
  });

  @override
  State<FootballField> createState() => _FootballFieldState();
}

class _FootballFieldState extends State<FootballField> {
  // ============================================================
  // PULSAR UNA POSICIÓN
  // ============================================================

  Future<void> _positionPressed(String positionId) async {
    final current = CurrentLineup.getPosition(positionId);

    // Si está vacía, directamente seleccionamos jugador
    if (current.player == null) {
      await _selectPlayer(positionId);
      return;
    }

    // Si ya hay jugador, mostramos opciones
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

  // ============================================================
  // SELECCIONAR JUGADOR
  // ============================================================

  Future<void> _selectPlayer(String positionId) async {
    // Posiciones permitidas para esa posición del campo
    final allowedPositions =
        PositionMapper.allowedPositions(positionId);

    // Jugadores que ya están colocados en el campo
    final usedPlayers = CurrentLineup.players.values
        .where((position) => position.player != null)
        .map((position) => position.player!.id)
        .toSet();

    // Posición actual
    final current = CurrentLineup.getPosition(positionId);

    // Si estamos cambiando un jugador, permitimos que vuelva
    if (current.player != null) {
      usedPlayers.remove(current.player!.id);
    }

    // Filtrar jugadores:
    // 1. Que no estén ya utilizados
    // 2. Que tengan una posición válida
    final players = PlayerService.getPlayers().where((player) {
      if (usedPlayers.contains(player.id)) {
        return false;
      }

      return player.positions.any(
        (position) => allowedPositions.contains(position),
      );
    }).toList();

    // Mostrar selector
    final Player? player = await showDialog<Player>(
      context: context,
      builder: (_) => PlayerSelectorDialog(
        players: players,
      ),
    );

    if (player == null) return;

    // Guardar jugador
    setState(() {
      current.player = player;
    });
  }

  // ============================================================
  // OBTENER LAS FORMACIONES
  // ============================================================

  Map<String, List<FieldPosition>> _getFormationMap() {
    // Todas las formaciones están dentro de Formations.data
    return Formations.data;
  }

  // ============================================================
  // OBTENER LAS POSICIONES DE LA FORMACIÓN ACTUAL
  // ============================================================

  List<FieldPosition> _getPositions() {
    final formationMap = _getFormationMap();

    // Buscar directamente la formación seleccionada
    final positions = formationMap[widget.formation];

    if (positions != null) {
      return positions;
    }

    // Si por algún motivo no existe, usamos la primera
    // formación disponible para evitar que la aplicación falle.
    if (formationMap.isNotEmpty) {
      return formationMap.values.first;
    }

    return [];
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final positions = _getPositions();

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
            // ==================================================
            // DIBUJAR CAMPO
            // ==================================================

            Positioned.fill(
              child: CustomPaint(
                painter: FieldPainter(),
              ),
            ),

            // ==================================================
            // POSICIONES
            // ==================================================

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