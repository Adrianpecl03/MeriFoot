import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../models/fine.dart';
import '../../models/player.dart';
import '../../services/fine_service.dart';
import '../../services/player_service.dart';

class AddFineScreen extends StatefulWidget {
  const AddFineScreen({super.key});

  @override
  State<AddFineScreen> createState() => _AddFineScreenState();
}

class _AddFineScreenState extends State<AddFineScreen> {
  final _formKey = GlobalKey<FormState>();

  final amountController = TextEditingController();
  final notesController = TextEditingController();

  final List<Player> players = PlayerService.getPlayers()
    ..sort((a, b) => a.number.compareTo(b.number));

  Player? selectedPlayer;

  final List<String> infringements = [
    "Llegar tarde",
    "No asistir al entrenamiento",
    "No avisar ausencia",
    "Tarjeta por protestar",
    "Expulsión",
    "No llevar la equipación",
    "Retraso en el pago",
    "Otro",
  ];

  String? selectedInfringement;

  DateTime selectedDate = DateTime.now();

  bool paid = false;

  @override
  void dispose() {
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Nueva multa"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B1020),
              Color(0xFF161F34),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [

                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
  children: [
                        Text(
                          "Jugador",
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        DropdownButtonFormField<Player>(
                          value: selectedPlayer,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF263548),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          dropdownColor: const Color(0xFF263548),
                          items: players.map((player) {
                            return DropdownMenuItem<Player>(
                              value: player,
                              child: Text(
                                "${player.number} · ${player.name}",
                              ),
                            );
                          }).toList(),
                          onChanged: (player) {
                            setState(() {
                              selectedPlayer = player;
                            });
                          },
                          validator: (value) =>
                              value == null ? "Selecciona un jugador" : null,
                        ),

                        const SizedBox(height: 22),

                        Text(
                          "Tipo de infracción",
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        DropdownButtonFormField<String>(
                          value: selectedInfringement,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF263548),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          dropdownColor: const Color(0xFF263548),
                          items: infringements.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedInfringement = value;
                            });
                          },
                          validator: (value) =>
                              value == null ? "Selecciona una infracción" : null,
                        ),

                        const SizedBox(height: 22),

                        Text(
                          "Importe (€)",
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextFormField(
                          controller: amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF263548),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Ej. 5",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Introduce un importe";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 22),

                        Text(
                          "Fecha",
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: pickDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF263548),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                  ),
                                ),
                                const Icon(Icons.calendar_month),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        Text(
                          "Observaciones",
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextFormField(
                          controller: notesController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF263548),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Opcional",
                          ),
                        ),

                        const SizedBox(height: 18),

                        SwitchListTile(
                          activeColor: const Color(0xFF22C55E),
                          value: paid,
                          title: const Text("Pagada"),
                          contentPadding: EdgeInsets.zero,
                          onChanged: (value) {
                            setState(() {
                              paid = value;
                            });
                          },
                        ),

                        const SizedBox(height: 28),

                        SizedBox(
                          height: 54,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF22C55E),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;

                              final fine = Fine(
                                id: const Uuid().v4(),
                                playerId: selectedPlayer!.id,
                                infringement: selectedInfringement!,
                                amount: double.parse(amountController.text),
                                date: selectedDate,
                                notes: notesController.text.trim().isEmpty
                                    ? null
                                    : notesController.text.trim(),
                                paid: paid,
                              );

                              await FineService.addFine(fine);

                              if (mounted) {
                                Navigator.pop(context);
                              }
                            },
                            icon: const Icon(Icons.save),
                            label: const Text(
                              "GUARDAR MULTA",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
