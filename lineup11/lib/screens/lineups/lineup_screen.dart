import 'package:flutter/material.dart';

import '../../models/current_bench.dart';
import '../../models/current_lineup.dart';
import '../../models/player.dart';
import '../../services/player_service.dart';
import '../../widgets/player_options_dialog.dart';
import '../../widgets/player_selector_dialog.dart';
import '../../widgets/player_slot.dart';

import 'football_field.dart';
import 'formations.dart';

class LineupScreen extends StatefulWidget {
  const LineupScreen({super.key});

  @override
  State<LineupScreen> createState() => _LineupScreenState();
}

class _LineupScreenState extends State<LineupScreen> {
  // ============================================================
  // TIPO DE FÚTBOL
  // ============================================================

  String selectedFootballType = "Fútbol 11";

  // ============================================================
  // FORMACIÓN ACTUAL
  // ============================================================

  String selectedFormation = "4-3-3";

  // ============================================================
  // BANQUILLO
  // ============================================================

  bool benchExpanded = false;

  // ============================================================
  // FORMACIONES
  // ============================================================

  final List<String> football11Formations = [
    "4-3-3",
    "4-4-2",
    "4-2-3-1",
    "4-1-4-1",
    "3-5-2",
    "3-4-3",
    "5-3-2",
  ];

  final List<String> football7Formations = [
    "7 - 2-3-1",
    "7 - 3-2-1",
    "7 - 3-1-2",
    "7 - 2-2-2",
  ];

  // ============================================================
  // CAMBIAR TIPO DE FÚTBOL
  // ============================================================

  void _changeFootballType(String type) {
    final formationMap = type == "Fútbol 7"
        ? Formations.data
        : Formations.data;

    final newFormation = type == "Fútbol 7"
        ? football7Formations.first
        : football11Formations.first;

    final newPositions = formationMap[newFormation] ?? [];

    // IDs de las posiciones que existen en la nueva formación.
    final validPositionIds =
        newPositions.map((position) => position.id).toSet();

    // Eliminamos jugadores de posiciones que ya no existen.
    CurrentLineup.players.removeWhere(
      (key, value) => !validPositionIds.contains(key),
    );

    setState(() {
      selectedFootballType = type;
      selectedFormation = newFormation;
    });
  }

  // ============================================================
  // CAMBIAR FORMACIÓN
  // ============================================================

  void _changeFormation(String formation) {
    final newPositions = Formations.data[formation] ?? [];

    final validPositionIds =
        newPositions.map((position) => position.id).toSet();

    // Eliminamos solamente las posiciones que no existen
    // en la nueva formación.
    CurrentLineup.players.removeWhere(
      (key, value) => !validPositionIds.contains(key),
    );

    setState(() {
      selectedFormation = formation;
    });
  }

  // ============================================================
  // JUGADOR DEL BANQUILLO
  // ============================================================

  Future<void> _benchSlotPressed(int index) async {
    final currentPlayer = CurrentBench.getPlayer(index);

    // Si está vacío, directamente seleccionamos jugador.
    if (currentPlayer == null) {
      await _selectBenchPlayer(index);
      return;
    }

    final option = await showDialog<PlayerOption>(
      context: context,
      builder: (_) => const PlayerOptionsDialog(),
    );

    if (option == null) return;

    switch (option) {
      case PlayerOption.change:
        await _selectBenchPlayer(index);
        break;

      case PlayerOption.remove:
        setState(() {
          CurrentBench.setPlayer(index, null);
        });
        break;
    }
  }

  // ============================================================
  // SELECCIONAR JUGADOR PARA EL BANQUILLO
  // ============================================================

  Future<void> _selectBenchPlayer(int index) async {
    final usedPlayers = <String>{};

    // Jugadores que están en el campo.
    for (final position in CurrentLineup.players.values) {
      if (position.player != null) {
        usedPlayers.add(position.player!.id);
      }
    }

    // Jugadores que ya están en el banquillo.
    for (final player in CurrentBench.players) {
      if (player != null) {
        usedPlayers.add(player.id);
      }
    }

    // Si estamos cambiando el jugador de ese slot,
    // permitimos que vuelva a seleccionarse.
    final current = CurrentBench.getPlayer(index);

    if (current != null) {
      usedPlayers.remove(current.id);
    }

    final availablePlayers = PlayerService
        .getPlayers()
        .where(
          (player) => !usedPlayers.contains(player.id),
        )
        .toList();

    final Player? player = await showDialog<Player>(
      context: context,
      builder: (_) => PlayerSelectorDialog(
        players: availablePlayers,
      ),
    );

    if (player == null) return;

    setState(() {
      CurrentBench.setPlayer(index, player);
    });
  }

  // ============================================================
  // LISTA DE FORMACIONES ACTUAL
  // ============================================================

  List<String> get currentFormations {
    if (selectedFootballType == "Fútbol 7") {
      return football7Formations;
    }

    return football11Formations;
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1020),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "Alineación",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          // ====================================================
          // SELECTOR FÚTBOL 11 / FÚTBOL 7
          // ====================================================

          DropdownButton<String>(
            value: selectedFootballType,

            dropdownColor: const Color(0xFF1E293B),

            underline: const SizedBox(),

            iconEnabledColor: Colors.white,

            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),

            items: const [
              DropdownMenuItem(
                value: "Fútbol 11",
                child: Text("Fútbol 11"),
              ),
              DropdownMenuItem(
                value: "Fútbol 7",
                child: Text("Fútbol 7"),
              ),
            ],

            onChanged: (value) {
              if (value == null) return;

              if (value == selectedFootballType) return;

              _changeFootballType(value);
            },
          ),

          const SizedBox(width: 8),

          // ====================================================
          // SELECTOR DE FORMACIÓN
          // ====================================================

          Padding(
            padding: const EdgeInsets.only(
              right: 12,
            ),

            child: DropdownButton<String>(
              value: selectedFormation,

              dropdownColor: const Color(0xFF1E293B),

              underline: const SizedBox(),

              iconEnabledColor: Colors.white,

              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),

              items: currentFormations
                  .map(
                    (formation) => DropdownMenuItem<String>(
                      value: formation,
                      child: Text(
                        formation,
                      ),
                    ),
                  )
                  .toList(),

              onChanged: (value) {
                if (value == null) return;

                _changeFormation(value);
              },
            ),
          ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: Stack(
        children: [
          // ====================================================
          // CAMPO
          // ====================================================

          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              60,
            ),

            child: FootballField(
              formation: selectedFormation,
              footballType: selectedFootballType,
            ),
          ),

          // ====================================================
          // BANQUILLO
          // ====================================================

          Align(
            alignment: Alignment.bottomCenter,

            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),

              curve: Curves.easeInOut,

              height: benchExpanded
                  ? 250
                  : 45,

              width: double.infinity,

              decoration: const BoxDecoration(
                color: Color(0xFF1A2233),

                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),

              child: Column(
                children: [
                  // ==============================================
                  // CABECERA DEL BANQUILLO
                  // ==============================================

                  InkWell(
                    onTap: () {
                      setState(() {
                        benchExpanded = !benchExpanded;
                      });
                    },

                    child: SizedBox(
                      height: 45,

                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [
                          Icon(
                            benchExpanded
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                          ),

                          const SizedBox(width: 8),

                          const Text(
                            "Banquillo",

                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ==============================================
                  // JUGADORES DEL BANQUILLO
                  // ==============================================

                  if (benchExpanded)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),

                        child: GridView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(),

                          itemCount: 15,

                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),

                          itemBuilder: (
                            context,
                            index,
                          ) {
                            return Center(
                              child: PlayerSlot(
                                width: 48,
                                height: 48,

                                player:
                                    CurrentBench.getPlayer(index),

                                onTap: () {
                                  _benchSlotPressed(index);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}