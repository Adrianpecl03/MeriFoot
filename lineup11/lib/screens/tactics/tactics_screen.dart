import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../models/tactic.dart';
import '../../services/tactic_service.dart';
import 'tactic_editor_screen.dart';

class TacticsScreen extends StatelessWidget {
  const TacticsScreen({super.key});

  // ----------------------------------------------------------
  // CREAR TÁCTICA
  // ----------------------------------------------------------

  Future<void> _createTactic(BuildContext context) async {
    final controller = TextEditingController();

    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: const Text(
            "Nueva jugada",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: "Nombre",
              hintText: "Ej. Salida de balón",
              filled: true,
              fillColor: const Color(0xFF0F172A),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                Navigator.pop(context, value.trim());
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                final value = controller.text.trim();

                if (value.isNotEmpty) {
                  Navigator.pop(context, value);
                }
              },
              child: const Text("Crear"),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (name == null || name.trim().isEmpty) {
      return;
    }

    final tactic = Tactic(
      id: const Uuid().v4(),
      name: name.trim(),
      createdAt: DateTime.now(),
      objects: [],
      arrows: [],
    );

    await TacticService.addTactic(tactic);

    if (!context.mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TacticEditorScreen(
          tactic: tactic,
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // RENOMBRAR
  // ----------------------------------------------------------

  Future<void> _renameTactic(
    BuildContext context,
    Tactic tactic,
  ) async {
    final controller = TextEditingController(
      text: tactic.name,
    );

    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: const Text(
            "Renombrar jugada",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: "Nombre",
              filled: true,
              fillColor: const Color(0xFF0F172A),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                Navigator.pop(context, value.trim());
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                final value = controller.text.trim();

                if (value.isNotEmpty) {
                  Navigator.pop(context, value);
                }
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (name == null || name.trim().isEmpty) {
      return;
    }

    tactic.name = name.trim();

    await TacticService.updateTactic(tactic);
  }

  // ----------------------------------------------------------
  // ELIMINAR
  // ----------------------------------------------------------

  Future<void> _deleteTactic(
    BuildContext context,
    Tactic tactic,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: const Text(
            "Eliminar jugada",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            '¿Quieres eliminar "${tactic.name}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );

    if (confirm != true) {
      return;
    }

    await TacticService.deleteTactic(tactic.id);
  }

  // ----------------------------------------------------------
  // UI
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1020),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _createTactic(context),
        child: const Icon(Icons.add),
      ),

      body: Container(
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
          child: ValueListenableBuilder<Box<Tactic>>(
            valueListenable:
                Hive.box<Tactic>("tactics_v2").listenable(),

            builder: (context, box, _) {
              final tactics = box.values.toList();

              return Column(
                children: [
                  // ------------------------------------------------
                  // HEADER
                  // ------------------------------------------------

                  Padding(
                    padding:
                        const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () =>
                                Navigator.pop(context),
                          ),
                        ),

                        const Expanded(
                          child: Center(
                            child: Text(
                              "Jugadas",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 48),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ------------------------------------------------
                  // LISTA
                  // ------------------------------------------------

                  Expanded(
                    child: tactics.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.sports_soccer,
                                  size: 70,
                                  color: Colors.white38,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "Todavía no hay jugadas",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white70,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Pulsa + para crear una",
                                  style: TextStyle(
                                    color: Colors.white38,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding:
                                const EdgeInsets.all(20),
                            itemCount: tactics.length,
                            itemBuilder:
                                (context, index) {
                              final tactic =
                                  tactics[index];

                              return Card(
                                color:
                                    const Color(0xFF1E293B),
                                margin:
                                    const EdgeInsets.only(
                                  bottom: 16,
                                ),
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                    18,
                                  ),
                                ),
                                child: ListTile(
                                  contentPadding:
                                      const EdgeInsets
                                          .fromLTRB(
                                    18,
                                    10,
                                    8,
                                    10,
                                  ),

                                  // ICONO
                                  leading:
                                      const CircleAvatar(
                                    backgroundColor:
                                        Color(0xFF0F172A),
                                    child: Icon(
                                      Icons.sports_soccer,
                                    ),
                                  ),

                                  // NOMBRE
                                  title: Text(
                                    tactic.name,
                                    style:
                                        const TextStyle(
                                      fontWeight:
                                          FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),

                                  // ELEMENTOS
                                  subtitle: Text(
                                    "${tactic.objects.length} elementos",
                                  ),

                                  // MENÚ
                                  trailing:
                                      PopupMenuButton<String>(
                                    onSelected:
                                        (value) async {
                                      if (value ==
                                          "rename") {
                                        await _renameTactic(
                                          context,
                                          tactic,
                                        );
                                      }

                                      if (value ==
                                          "delete") {
                                        await _deleteTactic(
                                          context,
                                          tactic,
                                        );
                                      }
                                    },
                                    itemBuilder:
                                        (context) => [
                                      const PopupMenuItem(
                                        value: "rename",
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                            ),
                                            SizedBox(
                                                width: 10),
                                            Text(
                                                "Renombrar"),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: "delete",
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color:
                                                  Colors.red,
                                            ),
                                            SizedBox(
                                                width: 10),
                                            Text(
                                              "Eliminar",
                                              style:
                                                  TextStyle(
                                                color:
                                                    Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  // ABRIR
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            TacticEditorScreen(
                                          tactic: tactic,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}