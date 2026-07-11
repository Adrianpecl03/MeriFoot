import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/player.dart';
import '../../widgets/stats_table.dart';
import 'edit_statistics_screen.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String searchText = "";

  int sortColumn = 0;
  bool ascending = true;

  void sortPlayers(int column) {

    setState(() {

      if (sortColumn == column) {
        ascending = !ascending;
      } else {
        sortColumn = column;
        ascending = true;
      }

    });

  }

  void applySort(List<Player> players) {

    int compare<T extends Comparable>(T a, T b) {
      return ascending ? a.compareTo(b) : b.compareTo(a);
    }

    switch (sortColumn) {

      case 0:
        players.sort((a,b)=>compare(a.name,b.name));
        break;

      case 1:
        players.sort((a,b)=>compare(a.matchesPlayed,b.matchesPlayed));
        break;

      case 2:
        players.sort((a,b)=>compare(a.matchesStarter,b.matchesStarter));
        break;

      case 3:
        players.sort((a,b)=>compare(a.matchesSubstitute,b.matchesSubstitute));
        break;

      case 4:
        players.sort((a,b)=>compare(a.goals,b.goals));
        break;

      case 5:
        players.sort((a,b)=>compare(a.assists,b.assists));
        break;

      case 6:
        players.sort((a,b)=>compare(a.yellowCards,b.yellowCards));
        break;

      case 7:
        players.sort((a,b)=>compare(a.redCards,b.redCards));
        break;

      case 8:
        players.sort((a,b)=>compare(a.cleanSheets,b.cleanSheets));
        break;

      case 9:
        players.sort((a,b)=>compare(a.goalsConceded,b.goalsConceded));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Player>("players");

    return Scaffold(
      backgroundColor: const Color(0xFF0B1020),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Estadísticas"),
      ),

      body: ValueListenableBuilder(
        valueListenable: box.listenable(),

        builder: (context, Box<Player> box, _) {

          List<Player> players = box.values.toList();

          players = players.where((player) {

            if (searchText.isEmpty) {
              return true;
            }

            return player.name
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                player.number
                    .toString()
                    .contains(searchText);

          }).toList();

          applySort(players);

          return Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Buscar jugador...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: const Color(0xFF1A2233),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: StatsTable(
                  players: players,

                  onSort: (column) {
                    sortPlayers(column);
                  },

                  onPlayerPressed: (player) async {

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditStatisticsScreen(
                          player: player,
                        ),
                      ),
                    );

                    setState(() {});
                  },
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}