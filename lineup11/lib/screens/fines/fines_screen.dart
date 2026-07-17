import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/fine.dart';
import '../../models/player.dart';
import '../../services/player_service.dart';
import '../../widgets/fine_card.dart';
import 'add_fine_screen.dart';

class FinesScreen extends StatelessWidget {
  const FinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final finesBox = Hive.box<Fine>("fines");

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddFineScreen(),
            ),
          );
        },
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
          child: ValueListenableBuilder(
            valueListenable: finesBox.listenable(),
            builder: (context, Box<Fine> box, _) {
              final fines = box.values.toList();

              double pending = 0;
              double paid = 0;

              for (final fine in fines) {
                if (fine.paid) {
                  paid += fine.amount;
                } else {
                  pending += fine.amount;
                }
              }

              final total = pending + paid;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),

                        const Expanded(
                          child: Center(
                            child: Text(
                              "Multas",
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

                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: _SummaryCard(
                            title: "Pendiente",
                            value: "${pending.toStringAsFixed(2)} €",
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SummaryCard(
                            title: "Pagado",
                            value: "${paid.toStringAsFixed(2)} €",
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SummaryCard(
                            title: "Total",
                            value: "${total.toStringAsFixed(2)} €",
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Expanded(
                    child: fines.isEmpty
                        ? const Center(
                            child: Text(
                              "Todavía no hay multas",
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: fines.length,
                            itemBuilder: (context, index) {
                              final fine = fines[index];

                              final Player? player =
                                  PlayerService.getPlayer(fine.playerId);

                              if (player == null) {
                                return const SizedBox.shrink();
                              }

                              return FineCard(
                                fine: fine,
                                player: player,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: const Color(0xFF1E293B),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24),
                                      ),
                                    ),
                                    builder: (_) {
                                      return SafeArea(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                leading: Icon(
                                                  fine.paid
                                                      ? Icons.cancel
                                                      : Icons.check_circle,
                                                ),
                                                title: Text(
                                                  fine.paid
                                                      ? "Marcar como pendiente"
                                                      : "Marcar como pagada",
                                                ),
                                                onTap: () async {
                                                  fine.paid = !fine.paid;

                                                  await fine.save();

                                                  if (context.mounted) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),

                                              ListTile(
                                                leading: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                title: const Text(
                                                  "Eliminar",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                onTap: () async {
                                                  await fine.delete();

                                                  if (context.mounted) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
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

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}