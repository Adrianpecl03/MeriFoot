import 'package:flutter/material.dart';

import '../../models/player.dart';
import '../../models/player_position.dart';
import '../../services/player_service.dart';
import 'dart:io';

import '../../services/image_service.dart';

class AddPlayerScreen extends StatefulWidget {
  final Player? player;

  const AddPlayerScreen({
    super.key,
    this.player,
  });

  @override
  State<AddPlayerScreen> createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String dominantFoot = "Derecho";
  String? imagePath;

  final List<PlayerPosition> selectedPositions = [];
  
  @override
  void initState() {
    debugPrint("Imagen cargada: ${widget.player?.imagePath}");
    super.initState();

    if (widget.player == null) return;

    final player = widget.player!;

    nameController.text = player.name;
    numberController.text = player.number.toString();

    ageController.text = player.age?.toString() ?? "";
    heightController.text = player.height?.toString() ?? "";
    weightController.text = player.weight?.toString() ?? "";
    notesController.text = player.notes ?? "";

    dominantFoot = player.dominantFoot ?? "Derecho";
    imagePath = player.imagePath;

    selectedPositions.addAll(player.positions);
  }

  void togglePosition(PlayerPosition position) {
    setState(() {
      if (selectedPositions.contains(position)) {
        selectedPositions.remove(position);
      } else {
        selectedPositions.add(position);
      }
    });
  }

  Widget positionChip(PlayerPosition position) {
    final selected = selectedPositions.contains(position);

    return GestureDetector(
      onTap: () => togglePosition(position),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF22C55E)
              : const Color(0xFF233248),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? Colors.greenAccent
                : Colors.white24,
          ),
        ),
        child: Text(
          position.name.toUpperCase(),
          style: TextStyle(
            color: selected
                ? Colors.black
                : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> savePlayer() async {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Introduce un nombre"),
        ),
      );
      return;
    }

    if (numberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Introduce un dorsal"),
        ),
      );
      return;
    }

    if (selectedPositions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Selecciona al menos una posición"),
        ),
      );
      return;
    }

    if (widget.player == null) {
      debugPrint("Ruta imagen: $imagePath");  
      await PlayerService.addPlayer(

        name: nameController.text.trim(),

        number: int.parse(numberController.text),

        positions: List.from(selectedPositions),

        imagePath: imagePath,

        age: ageController.text.isEmpty
            ? null
            : int.parse(ageController.text),

        height: heightController.text.isEmpty
            ? null
            : double.parse(heightController.text),

        weight: weightController.text.isEmpty
            ? null
            : double.parse(weightController.text),

        dominantFoot: dominantFoot,

        notes: notesController.text.isEmpty
            ? null
            : notesController.text,

      );

    } else {

      widget.player!.name = nameController.text.trim();

      widget.player!.number =
          int.parse(numberController.text);

      widget.player!.positions =
          List.from(selectedPositions);

      widget.player!.imagePath = imagePath;
      
      widget.player!.age =
          ageController.text.isEmpty
              ? null
              : int.parse(ageController.text);

      widget.player!.height =
          heightController.text.isEmpty
              ? null
              : double.parse(heightController.text);

      widget.player!.weight =
          weightController.text.isEmpty
              ? null
              : double.parse(weightController.text);

      widget.player!.dominantFoot =
          dominantFoot;

      widget.player!.notes =
          notesController.text.isEmpty
              ? null
              : notesController.text;

      await PlayerService.updatePlayer(
        widget.player!,
      );

    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1020),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        title: Text(
          widget.player == null
              ? "Nuevo jugador"
              : "Editar jugador",
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(

                onTap: () async {

                  final path = await ImageService.pickImage();

                  if (path != null) {

                    setState(() {

                      imagePath = path;

                    });

                  }

                },

                child: CircleAvatar(

                  radius: 55,

                  backgroundColor: const Color(0xFF233248),

                  backgroundImage: imagePath != null
                      ? FileImage(File(imagePath!))
                      : null,

                  child: imagePath == null
                      ? const Icon(
                          Icons.add_a_photo,
                          size: 38,
                        )
                      : null,

                ),

              ),

            ),
            const SizedBox(height: 30),

            const Text("Nombre"),
            const SizedBox(height: 8),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Nombre",
              ),
            ),

            const SizedBox(height: 20),

            const Text("Dorsal"),
            const SizedBox(height: 8),

            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "10",
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Posiciones",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: PlayerPosition.values
                  .map(positionChip)
                  .toList(),
            ),

            const SizedBox(height: 30),

            const Text(
              "Edad",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            const Text(
              "Altura (cm)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            const Text(
              "Peso (kg)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            const Text(
              "Pie dominante",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: dominantFoot,
              dropdownColor: const Color(0xFF1E293B),

              items: const [

                DropdownMenuItem(
                  value: "Derecho",
                  child: Text("Derecho"),
                ),

                DropdownMenuItem(
                  value: "Izquierdo",
                  child: Text("Izquierdo"),
                ),

                DropdownMenuItem(
                  value: "Ambidiestro",
                  child: Text("Ambidiestro"),
                ),

              ],

              onChanged: (value) {
                setState(() {
                  dominantFoot = value!;
                });
              },

            ),

            const SizedBox(height: 20),

            const Text(
              "Observaciones",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: notesController,
              maxLines: 5,
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22C55E),
                  foregroundColor: Colors.white,
                ),

                onPressed: savePlayer,

                child: Text(

                  widget.player == null
                      ? "Guardar jugador"
                      : "Guardar cambios",

                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),

                ),

              ),

            ),

            const SizedBox(height: 30),

          ],

        ),

      ),

    );

  }

}