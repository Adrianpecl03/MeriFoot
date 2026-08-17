import 'package:flutter/material.dart';

import '../models/player.dart';

class StatsRow extends StatelessWidget {
  final Player player;
  final VoidCallback onTap;

  const StatsRow({
    super.key,
    required this.player,
    required this.onTap,
  });

  Widget stat(dynamic value, {double width = 28}) {
    return SizedBox(
      width: width,
      child: Center(
        child: Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isGoalkeeper = player.positions.any(
      (p) => p.name == "por",
    );

    return InkWell(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),

        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white10,
            ),
          ),
        ),

        child: Row(
          children: [

            SizedBox(
              width: 120,
              child: Text(
                player.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            stat(player.matchesPlayed),

            stat(player.matchesStarter),

            stat(player.matchesSubstitute),

            stat(player.goals),

            stat(player.assists),

            stat(player.yellowCards),

            stat(player.redCards),

            stat(
              isGoalkeeper
                  ? player.cleanSheets
                  : "-",
            ),

            stat(
              isGoalkeeper
                  ? player.goalsConceded
                  : "-",
            ),

          ],
        ),
      ),
    );
  }
}