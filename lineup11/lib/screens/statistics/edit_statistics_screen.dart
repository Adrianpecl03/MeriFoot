import 'package:flutter/material.dart';

import '../../models/player.dart';

class EditStatisticsScreen extends StatefulWidget {
  final Player player;

  const EditStatisticsScreen({
    super.key,
    required this.player,
  });

  @override
  State<EditStatisticsScreen> createState() =>
      _EditStatisticsScreenState();
}

class _EditStatisticsScreenState
    extends State<EditStatisticsScreen> {

  late int matchesPlayed;
  late int matchesStarter;
  late int matchesSubstitute;
  late int goals;
  late int assists;
  late int yellowCards;
  late int redCards;
  late int cleanSheets;
  late int goalsConceded;

  @override
  void initState() {
    super.initState();

    matchesPlayed = widget.player.matchesPlayed;
    matchesStarter = widget.player.matchesStarter;
    matchesSubstitute = widget.player.matchesSubstitute;
    goals = widget.player.goals;
    assists = widget.player.assists;
    yellowCards = widget.player.yellowCards;
    redCards = widget.player.redCards;
    cleanSheets = widget.player.cleanSheets;
    goalsConceded = widget.player.goalsConceded;
  }

  Widget statRow(
    String title,
    int value,
    VoidCallback minus,
    VoidCallback plus,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          IconButton(
            onPressed: minus,
            icon: const Icon(Icons.remove_circle_outline),
          ),

          SizedBox(
            width: 35,
            child: Center(
              child: Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          IconButton(
            onPressed: plus,
            icon: const Icon(Icons.add_circle_outline),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFF0B1020),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.player.name),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            statRow(
              "PJ",
              matchesPlayed,
              () {
                if (matchesPlayed > 0) {
                  setState(() => matchesPlayed--);
                }
              },
              () {
                setState(() => matchesPlayed++);
              },
            ),

            statRow(
              "Titular",
              matchesStarter,
              () {
                if (matchesStarter > 0) {
                  setState(() => matchesStarter--);
                }
              },
              () {
                setState(() => matchesStarter++);
              },
            ),

            statRow(
              "Suplente",
              matchesSubstitute,
              () {
                if (matchesSubstitute > 0) {
                  setState(() => matchesSubstitute--);
                }
              },
              () {
                setState(() => matchesSubstitute++);
              },
            ),

            statRow(
              "⚽ Goles",
              goals,
              () {
                if (goals > 0) {
                  setState(() => goals--);
                }
              },
              () {
                setState(() => goals++);
              },
            ),

            statRow(
              "🎯 Asistencias",
              assists,
              () {
                if (assists > 0) {
                  setState(() => assists--);
                }
              },
              () {
                setState(() => assists++);
              },
            ),

            statRow(
              "🟨 Amarillas",
              yellowCards,
              () {
                if (yellowCards > 0) {
                  setState(() => yellowCards--);
                }
              },
              () {
                setState(() => yellowCards++);
              },
            ),

            statRow(
              "🟥 Rojas",
              redCards,
              () {
                if (redCards > 0) {
                  setState(() => redCards--);
                }
              },
              () {
                setState(() => redCards++);
              },
            ),

            statRow(
              "CS",
              cleanSheets,
              () {
                if (cleanSheets > 0) {
                  setState(() => cleanSheets--);
                }
              },
              () {
                setState(() => cleanSheets++);
              },
            ),

            statRow(
              "GC",
              goalsConceded,
              () {
                if (goalsConceded > 0) {
                  setState(() => goalsConceded--);
                }
              },
              () {
                setState(() => goalsConceded++);
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(

                onPressed: () async {

                  widget.player.matchesPlayed = matchesPlayed;
                  widget.player.matchesStarter = matchesStarter;
                  widget.player.matchesSubstitute = matchesSubstitute;
                  widget.player.goals = goals;
                  widget.player.assists = assists;
                  widget.player.yellowCards = yellowCards;
                  widget.player.redCards = redCards;
                  widget.player.cleanSheets = cleanSheets;
                  widget.player.goalsConceded = goalsConceded;

                  await widget.player.save();

                  if (!mounted) return;

                  Navigator.pop(context);

                },

                child: const Text(
                  "Guardar",
                ),

              ),

            ),

          ],
        ),
      ),
    );
  }
}