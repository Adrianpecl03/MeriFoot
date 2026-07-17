import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/callup.dart';
import '../../models/player.dart';
import '../../services/callup_service.dart';

import 'callup_preview_screen.dart';
import '../../services/player_service.dart';

class AddCallupScreen extends StatefulWidget {
  final Callup? callup;

  const AddCallupScreen({
    super.key,
    this.callup,
  });

  @override
  State<AddCallupScreen> createState() => _AddCallupScreenState();
}

class _AddCallupScreenState extends State<AddCallupScreen> {

  final TextEditingController opponentController =
      TextEditingController();

  final TextEditingController fieldController =
      TextEditingController();

  final TextEditingController timeController =
      TextEditingController();

  DateTime selectedDate = DateTime.now();

  final List<String> selectedPlayers = [];

  @override
  void initState() {
    super.initState();

    if (widget.callup == null) return;

    opponentController.text = widget.callup!.opponent;
    fieldController.text = widget.callup!.field;
    timeController.text = widget.callup!.time;

    selectedDate = widget.callup!.date;

    selectedPlayers.addAll(
      widget.callup!.playerIds,
    );
  }

  @override
  Widget build(BuildContext context) {

    final playersBox = Hive.box<Player>("players");
    final players = playersBox.values.toList()
      ..sort((a, b) => a.number.compareTo(b.number));

    return Scaffold(

      backgroundColor: const Color(0xFF0B1020),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.callup == null
              ? "Nueva convocatoria"
              : "Editar convocatoria",
        ),
      ),

      body: ListView(

        padding: const EdgeInsets.all(20),

        children: [

          const Text("Rival"),

          const SizedBox(height: 8),

          TextField(
            controller: opponentController,
          ),

          const SizedBox(height: 20),

          const Text("Campo"),

          const SizedBox(height: 8),

          TextField(
            controller: fieldController,
          ),

          const SizedBox(height: 20),

          const Text("Hora"),

          const SizedBox(height: 8),

          TextField(
            controller: timeController,
            decoration: const InputDecoration(
              hintText: "16:00",
            ),
          ),

          const SizedBox(height: 20),

          ListTile(

            title: const Text("Fecha"),

            subtitle: Text(
              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
            ),

            trailing: const Icon(Icons.calendar_month),

            onTap: () async {

              final date = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2024),
                lastDate: DateTime(2035),
              );

              if (date != null) {

                setState(() {

                  selectedDate = date;

                });

              }

            },

          ),

          const SizedBox(height: 25),

          const Text(
            "Convocados",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 10),

          ...players.map((player) {

            final selected = selectedPlayers.contains(player.id);

            return InkWell(

              onTap: () {

                setState(() {

                  if (selected) {
                    selectedPlayers.remove(player.id);
                  } else {
                    selectedPlayers.add(player.id);
                  }

                });

              },

              child: Container(

                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),

                decoration: const BoxDecoration(

                  border: Border(

                    bottom: BorderSide(
                      color: Colors.white12,
                    ),

                  ),

                ),

                child: Row(

                  children: [

                    SizedBox(

                      width: 40,

                      child: Text(

                        player.number.toString(),

                        style: const TextStyle(

                          fontSize: 17,
                          fontWeight: FontWeight.bold,

                        ),

                      ),

                    ),

                    Expanded(

                      child: Text(

                        player.name,

                        style: const TextStyle(
                          fontSize: 16,
                        ),

                      ),

                    ),

                    Checkbox(

                      value: selected,

                      onChanged: (_) {

                        setState(() {

                          if (selected) {
                            selectedPlayers.remove(player.id);
                          } else {
                            selectedPlayers.add(player.id);
                          }

                        });

                      },

                    ),

                  ],

                ),

              ),

            );

          }),

          const SizedBox(height: 30),

          SizedBox(

            height: 55,

            child: ElevatedButton(

              onPressed: () async {

                Callup callup;

                if (widget.callup == null) {

                  callup = Callup(

                    id: DateTime.now().millisecondsSinceEpoch.toString(),

                    title: opponentController.text,

                    opponent: opponentController.text,

                    date: selectedDate,

                    time: timeController.text,

                    field: fieldController.text,

                    playerIds: List.from(selectedPlayers),

                  );

                  final box = Hive.box<Callup>("callups");

                  await box.put(callup.id, callup);

                } else {

                  widget.callup!.title = opponentController.text;
                  widget.callup!.opponent = opponentController.text;
                  widget.callup!.date = selectedDate;
                  widget.callup!.time = timeController.text;
                  widget.callup!.field = fieldController.text;
                  widget.callup!.playerIds = List.from(selectedPlayers);

                  await widget.callup!.save();

                  callup = widget.callup!;
                }

                if (!mounted) return;

                final players = PlayerService.getPlayers();

                await Navigator.pushReplacement(

                  context,

                  MaterialPageRoute(

                    builder: (_) => CallupPreviewScreen(

                      callup: callup,

                      players: players,

                    ),

                  ),

                );

              },
              child: Text(
                widget.callup == null
                    ? "Guardar convocatoria"
                    : "Guardar cambios",
              ),

            ),

          ),

        ],

      ),

    );

  }

}