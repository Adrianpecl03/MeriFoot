import 'package:flutter/material.dart';
import '../../models/current_bench.dart';
import '../../models/current_lineup.dart';
import '../../models/player.dart';
import '../../services/player_service.dart';
import '../../widgets/player_options_dialog.dart';
import '../../widgets/player_selector_dialog.dart';
import '../../widgets/player_slot.dart';

import 'football_field.dart';

class LineupScreen extends StatefulWidget {
  const LineupScreen({super.key});

  @override
  State<LineupScreen> createState() => _LineupScreenState();
}

class _LineupScreenState extends State<LineupScreen> {
  String selectedFormation = "4-3-3";

  bool benchExpanded = false;

  final List<String> formations = [
    "4-3-3",
    "4-4-2",
    "4-2-3-1",
    "4-1-4-1",
    "3-5-2",
    "3-4-3",
    "5-3-2",
  ];

  Future<void> _benchSlotPressed(int index) async {

    final currentPlayer = CurrentBench.getPlayer(index);

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

  Future<void> _selectBenchPlayer(int index) async {

    final usedPlayers = <String>{};

    // Jugadores del campo
    for (final p in CurrentLineup.players.values) {
      if (p.player != null) {
        usedPlayers.add(p.player!.id);
      }
    }

    // Jugadores del banquillo
    for (final p in CurrentBench.players) {
      if (p != null) {
        usedPlayers.add(p.id);
      }
    }

    final current = CurrentBench.getPlayer(index);

    if (current != null) {
      usedPlayers.remove(current.id);
    }

    final availablePlayers = PlayerService
        .getPlayers()
        .where((player) => !usedPlayers.contains(player.id))
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1020),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        centerTitle: true,

        title: const Text(
          "Alineación",
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 12,
            ),

            child: DropdownButton<String>(
              value: selectedFormation,

              dropdownColor: const Color(
                0xFF1E293B,
              ),

              underline: const SizedBox(),

              iconEnabledColor: Colors.white,

              items: formations
                  .map(
                    (formation) =>
                        DropdownMenuItem(
                      value: formation,
                      child: Text(
                        formation,
                      ),
                    ),
                  )
                  .toList(),

              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  selectedFormation = value;
                });
              },
            ),
          ),
        ],
      ),

      body: Stack(
        children: [

          Padding(
            padding:
                const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              60,
            ),

            child: FootballField(
              formation: selectedFormation,
            ),
          ),

          Align(
            alignment:
                Alignment.bottomCenter,

            child: AnimatedContainer(
              duration:
                  const Duration(
                milliseconds: 300,
              ),

              curve:
                  Curves.easeInOut,

              height:
                  benchExpanded
                      ? 250
                      : 45,

              width: double.infinity,

              decoration:
                  const BoxDecoration(
                color: Color(
                  0xFF1A2233,
                ),

                borderRadius:
                    BorderRadius.vertical(
                  top:
                      Radius.circular(
                    25,
                  ),
                ),
              ),

              child: Column(
                children: [

                  InkWell(
                    onTap: () {
                      setState(() {
                        benchExpanded =
                            !benchExpanded;
                      });
                    },

                    child: SizedBox(
                      height: 45,

                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [

                          Icon(
                            benchExpanded
                                ? Icons
                                    .keyboard_arrow_down
                                : Icons
                                    .keyboard_arrow_up,
                          ),

                          const SizedBox(
                            width: 8,
                          ),

                          const Text(
                            "Banquillo",

                            style:
                                TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (benchExpanded)
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets
                                .all(
                          15,
                        ),

                        child:
                            GridView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(),

                          itemCount: 15,

                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                5,

                            crossAxisSpacing:
                                12,

                            mainAxisSpacing:
                                12,
                          ),

                          itemBuilder:
                              (
                            context,
                            index,
                          ) {
                             return Center(
                              child: PlayerSlot(
                                width: 48,
                                height: 48,

                                player: CurrentBench.getPlayer(index),

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