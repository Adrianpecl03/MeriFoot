import 'package:flutter/material.dart';

import '../models/player.dart';

class PlayerSelectorDialog extends StatelessWidget {
  final List<Player> players;

  const PlayerSelectorDialog({
    super.key,
    required this.players,
  });

  @override
  Widget build(BuildContext context) {
    if (players.isEmpty) {
      return AlertDialog(
        title: const Text("Sin jugadores"),
        content: const Text(
          "No hay jugadores disponibles para esta posición.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Aceptar"),
          ),
        ],
      );
    }

    return AlertDialog(
      title: const Text("Seleccionar jugador"),
      content: SizedBox(
        width: 350,
        height: 420,
        child: ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, index) {
            final player = players[index];

            return Card(
              color: const Color(0xFF233248),
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF22C55E),
                  child: Text(
                    player.number.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                title: Text(player.name),
                subtitle: Text(
                  player.positions
                      .map((e) => e.name.toUpperCase())
                      .join(" · "),
                ),
                onTap: () {
                  Navigator.pop(context, player);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}