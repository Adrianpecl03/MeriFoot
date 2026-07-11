import 'package:flutter/material.dart';

enum PlayerAction {
  edit,
  delete,
}

class PlayerActionsDialog extends StatelessWidget {
  const PlayerActionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Jugador"),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Editar jugador"),
            onTap: () {
              Navigator.pop(
                context,
                PlayerAction.edit,
              );
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: const Text(
              "Eliminar jugador",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onTap: () {
              Navigator.pop(
                context,
                PlayerAction.delete,
              );
            },
          ),

        ],
      ),
    );
  }
}