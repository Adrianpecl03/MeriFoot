import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/player.dart';
import 'add_player_screen.dart';


import '../../services/player_service.dart';
import '../../widgets/player_actions_dialog.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  String searchText = "";


  Future<void> _playerPressed(Player player) async {

    final action = await showDialog<PlayerAction>(
      context: context,
      builder: (_) => const PlayerActionsDialog(),
    );

    if (action == null) return;

    switch (action) {

      case PlayerAction.edit:

        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddPlayerScreen(
              player: player,
            ),
          ),
        );

        break;

      case PlayerAction.delete:

        final confirm = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Eliminar jugador"),
            content: Text(
              "¿Seguro que quieres eliminar a ${player.name}?",
            ),
            actions: [

              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text("Cancelar"),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text("Eliminar"),
              ),

            ],
          ),
        );

        if (confirm != true) return;

        await PlayerService.deletePlayer(player.id);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${player.name} eliminado"),
          ),
        );

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
        title: const Text(
          "Jugadores",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF22C55E),
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddPlayerScreen(),
            ),
          );

          setState(() {});
        },
      ),

      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Player> box, _) {

          final players = box.values.toList();

          final filteredPlayers = players.where((player) {

            if (searchText.isEmpty) return true;

            return player.name
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                player.number
                    .toString()
                    .contains(searchText);

          }).toList();

          return Column(
            children: [

              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
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

                child: filteredPlayers.isEmpty

                    ? const Center(
                        child: Text(
                          "No se encontraron jugadores",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      )

                    : ListView.builder(

                        padding: const EdgeInsets.symmetric(horizontal: 15),

                        itemCount: filteredPlayers.length,

                        itemBuilder: (context, index) {

                          final player = filteredPlayers[index];

                          return Card(

                            color: const Color(0xFF1A2233),

                            margin: const EdgeInsets.only(bottom: 12),

                            child: ListTile(

                              leading: CircleAvatar(
                                backgroundColor: const Color(0xFF233248),
                                child: Text(
                                  player.number.toString(),
                                ),
                              ),

                              title: Text(player.name),

                              subtitle: Text(
                                player.positions
                                    .map((e) => e.name.toUpperCase())
                                    .join(" • "),
                              ),

                              trailing: const Icon(
                                Icons.chevron_right,
                              ),

                              onTap: () {
                                _playerPressed(player);
                              },

                            ),

                          );

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