import 'package:flutter/material.dart';
import 'package:MeriFoot/screens/statistics/statistics_screen.dart';

import '../lineups/lineup_screen.dart';
import '../players/players_screen.dart';
import '../callups/callups_screen.dart';
import '../fines/fines_screen.dart';
import '../tactics/tactics_screen.dart';
// import '../class_api/league_test_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B1020),
              Color(0xFF161F34),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),

                Column(
                  children: [
                    const Text(
                      "LINEUP11",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Image.asset(
                      "assets/images/meridiana.png",
                      height: 80,
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    children: [

                      MenuCard(
                        icon: Icons.sports_soccer,
                        title: "Alineaciones",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LineupScreen(),
                            ),
                          );
                        },
                      ),

                      MenuCard(
                        icon: Icons.groups,
                        title: "Jugadores",
                        onTap: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PlayersScreen(),
                            ),
                          );
                        },
                      ),

                      MenuCard(
                        icon: Icons.route,
                        title: "Jugadas",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TacticsScreen(),
                            ),
                          );
                        },
                      ),

                      MenuCard(
                        icon: Icons.bar_chart,
                        title: "Estadísticas",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const StatisticsScreen(),
                            ),
                          );
                        },
                      ),
                      MenuCard(
                        icon: Icons.assignment,
                        title: "Convocatorias",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CallupsScreen(),
                            ),
                          );
                        },
                      ),
                      MenuCard(
                        icon: Icons.attach_money,
                        title: "Multas",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const FinesScreen(),
                            ),
                          );
                        },
                      ),
                      // MenuCard(
                      //   icon: Icons.attach_money,
                      //   title: "LIGA",
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (_) => const LeagueTestScreen(),
                      //       ),
                      //     );
                      //   },
                      // ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E293B),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: const Color(0xFF22C55E),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}