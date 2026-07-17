import 'package:flutter/material.dart';

import '../../models/callup.dart';
import '../../models/player.dart';

class CallupPreviewScreen extends StatelessWidget {
  final Callup callup;
  final List<Player> players;

  const CallupPreviewScreen({
    super.key,
    required this.callup,
    required this.players,
  });

  @override
  Widget build(BuildContext context) {

    final convocados = players
        .where((p) => callup.playerIds.contains(p.id))
        .toList()
      ..sort((a, b) => a.number.compareTo(b.number));

    return Scaffold(

      backgroundColor: const Color(0xFF0B1020),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Vista previa"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Container(

          width: double.infinity,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF14532D),
                Color(0xFF166534),
                Color(0xFF0F3D23),
              ],
            ),
          ),

          child: Column(

            children: [

              const SizedBox(height: 30),

              Image.asset(
                "assets/images/meridiana.png",
                height: 80,
              ),

              const SizedBox(height: 15),

              const Text(
                "CONVOCATORIA",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 25),

              Text(
                "🆚 ${callup.opponent.toUpperCase()}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "${callup.date.day.toString().padLeft(2, '0')}/"
                "${callup.date.month.toString().padLeft(2, '0')}/"
                "${callup.date.year}",
              ),

              const SizedBox(height: 35),

              const Divider(),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GridView.builder(

                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: convocados.length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount: 2,

                      childAspectRatio: 5,

                      crossAxisSpacing: 25,

                    ),

                    itemBuilder: (context, index) {

                      final player = convocados[index];

                      return Row(

                        children: [

                          SizedBox(

                            width: 28,

                            child: Text(

                              player.number.toString(),

                              style: const TextStyle(

                                fontWeight: FontWeight.bold,

                                fontSize: 16,

                              ),

                            ),

                          ),

                          Expanded(

                            child: Text(

                              player.name.toUpperCase(),

                              overflow: TextOverflow.ellipsis,

                              style: const TextStyle(

                                fontSize: 15,

                              ),

                            ),

                          ),

                        ],

                      );

                    },

                  ),
                ),
              ),

              

            ],

          ),

        ),

      ),

    );

  }

}