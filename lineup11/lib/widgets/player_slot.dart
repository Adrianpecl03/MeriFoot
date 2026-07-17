import 'dart:io';

import 'package:flutter/material.dart';

import '../models/player.dart';

class PlayerSlot extends StatelessWidget {
  final Player? player;
  final VoidCallback onTap;

  final double width;
  final double height;

  const PlayerSlot({
    super.key,
    required this.player,
    required this.onTap,
    this.width = 65,
    this.height = 90,
  });

  @override
  Widget build(BuildContext context) {
    final slot = GestureDetector(
      onTap: onTap,

      child: SizedBox(
        width: width,
        height: height,

        child: player == null

            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [

                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Color(0xFF233248),
                    child: Icon(Icons.add),
                  ),

                  SizedBox(height: 6),

                ],
              )

            : Column(
                children: [

                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFF233248),

                    backgroundImage: player!.imagePath != null
                        ? FileImage(File(player!.imagePath!))
                        : null,

                    child: player!.imagePath == null
                        ? const Icon(Icons.person)
                        : null,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    player!.number.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),

                  SizedBox(
                    width: width,
                    child: Text(
                      player!.name,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );

    if (player == null) {
      return slot;
    }

    return Draggable<Player>(
      data: player,

      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: width,
          height: height,
          child: slot,
        ),
      ),

      childWhenDragging: Opacity(
        opacity: .35,
        child: slot,
      ),

      child: slot,
    );
  }
}