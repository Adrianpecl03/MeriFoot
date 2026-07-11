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
    this.width = 50,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {

    final widget = GestureDetector(

      onTap: onTap,

      child: Container(

        width: width,
        height: height,

        decoration: BoxDecoration(

          color: const Color(0xFF233248),

          borderRadius: BorderRadius.circular(10),

          border: Border.all(
            color: Colors.white24,
          ),

        ),

        child: player == null

            ? const Icon(
                Icons.add,
                color: Colors.white,
              )

            : Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Text(

                    player!.number.toString(),

                    style: const TextStyle(

                      fontWeight: FontWeight.bold,

                      fontSize: 12,

                    ),

                  ),

                  Padding(

                    padding: const EdgeInsets.symmetric(horizontal: 2),

                    child: Text(

                      player!.name,

                      overflow: TextOverflow.ellipsis,

                      maxLines: 1,

                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        fontSize: 8,
                      ),

                    ),

                  ),

                ],

              ),

      ),

    );

    if (player == null) {
      return widget;
    }

    return Draggable<Player>(

      data: player,

      feedback: Material(

        color: Colors.transparent,

        child: SizedBox(

          width: width,

          height: height,

          child: widget,

        ),

      ),

      childWhenDragging: Opacity(

        opacity: .35,

        child: widget,

      ),

      child: widget,

    );

  }

}