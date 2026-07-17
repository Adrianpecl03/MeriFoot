import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/callup.dart';
import 'add_callup_screen.dart';

class CallupsScreen extends StatelessWidget {
  const CallupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Callup>("callups");

    return Scaffold(
      backgroundColor: const Color(0xFF0B1020),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Convocatorias",
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
              builder: (_) => const AddCallupScreen(),
            ),
          );
        },
      ),

      body: ValueListenableBuilder(
        valueListenable: box.listenable(),

        builder: (context, Box<Callup> box, _) {

          final callups = box.values.toList();

          if (callups.isEmpty) {

            return const Center(
              child: Text(
                "Todavía no hay convocatorias",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
            );

          }

          return ListView.builder(

            padding: const EdgeInsets.all(15),

            itemCount: callups.length,

            itemBuilder: (context, index) {

              final callup = callups[index];

              return Card(

                color: const Color(0xFF1A2233),

                margin: const EdgeInsets.only(bottom: 12),

                child: ListTile(

                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF233248),
                    child: Icon(Icons.assignment),
                  ),

                  title: Text(
                    callup.opponent,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    "${callup.date.day.toString().padLeft(2, '0')}/"
                    "${callup.date.month.toString().padLeft(2, '0')}/"
                    "${callup.date.year}",
                  ),

                  trailing: const Icon(
                    Icons.chevron_right,
                  ),

                  onTap: () async{
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddCallupScreen(
                          callup: callup,
                        ),
                      ),
                    );
                  },

                ),

              );

            },

          );

        },

      ),

    );
  }
}