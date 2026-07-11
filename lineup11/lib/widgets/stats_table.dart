import 'package:flutter/material.dart';

import '../models/player.dart';
import 'stats_row.dart';

class StatsTable extends StatelessWidget {
  final List<Player> players;

  final void Function(Player) onPlayerPressed;

  final void Function(int column) onSort;

  const StatsTable({
    super.key,
    required this.players,
    required this.onPlayerPressed,
    required this.onSort,
  });

  Widget header(
    String text,
    int column, {
    double width = 28,
  }) {
    return InkWell(
      onTap: () => onSort(column),
      child: SizedBox(
        width: width,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 12,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white30,
              ),
            ),
          ),
          child: Row(
            children: [

              InkWell(
                onTap: () => onSort(0),
                child: const SizedBox(
                  width: 120,
                  child: Text(
                    "Jugador",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              header("PJ", 1),
              header("T", 2),
              header("S", 3),
              header("⚽", 4),
              header("🎯", 5),
              header("AM", 6),
              header("RO", 7),
              header("CS", 8),
              header("GC", 9),

            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: players.length,
            itemBuilder: (context, index) {
              return StatsRow(
                player: players[index],
                onTap: () {
                  onPlayerPressed(
                    players[index],
                  );
                },
              );
            },
          ),
        ),

      ],
    );
  }
}