import 'package:flutter/material.dart';

enum PlayerOption {
  change,
  remove,
}

class PlayerOptionsDialog extends StatelessWidget {
  const PlayerOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Jugador"),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          ListTile(
            leading: const Icon(Icons.swap_horiz),
            title: const Text("Cambiar jugador"),
            onTap: () {
              Navigator.pop(
                context,
                PlayerOption.change,
              );
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: const Text(
              "Quitar jugador",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.pop(
                context,
                PlayerOption.remove,
              );
            },
          ),

        ],
      ),
    );
  }
}