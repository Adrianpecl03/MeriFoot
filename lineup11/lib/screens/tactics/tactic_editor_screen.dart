import 'package:flutter/material.dart';

import '../../models/tactic.dart';
import '../../services/tactic_history_service.dart';
import '../../services/tactic_service.dart';
import '../../widgets/tactics/tactic_canvas.dart';
import '../../widgets/tactics/tactic_toolbar.dart';

class TacticEditorScreen extends StatefulWidget {
  final Tactic tactic;

  const TacticEditorScreen({
    super.key,
    required this.tactic,
  });

  @override
  State<TacticEditorScreen> createState() =>
      _TacticEditorScreenState();
}

class _TacticEditorScreenState
    extends State<TacticEditorScreen> {
  String selectedTool = "select";

  final TacticHistoryService history =
      TacticHistoryService();

  Future<void> _saveTactic() async {
    await TacticService.updateTactic(widget.tactic);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Jugada guardada"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation ==
            Orientation.portrait;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1020),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        title: Text(
          widget.tactic.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          // DESHACER
          IconButton(
            tooltip: "Deshacer",
            icon: const Icon(Icons.undo),
            onPressed: () {
              setState(() {
                history.undo(widget.tactic);
              });
            },
          ),

          // REHACER
          IconButton(
            tooltip: "Rehacer",
            icon: const Icon(Icons.redo),
            onPressed: () {
              setState(() {
                history.redo(widget.tactic);
              });
            },
          ),

          // GUARDAR
          IconButton(
            tooltip: "Guardar",
            icon: const Icon(Icons.save),
            onPressed: _saveTactic,
          ),
        ],
      ),

      body: isPortrait
          ? Column(
              children: [
                Expanded(
                  child: TacticCanvas(
                    tactic: widget.tactic,
                    selectedTool: selectedTool,
                    history: history,
                  ),
                ),

                TacticToolbar(
                  vertical: false,
                  selectedTool: selectedTool,
                  onToolSelected: (tool) {
                    setState(() {
                      selectedTool = tool;
                    });
                  },
                ),
              ],
            )
          : Row(
              children: [
                TacticToolbar(
                  vertical: true,
                  selectedTool: selectedTool,
                  onToolSelected: (tool) {
                    setState(() {
                      selectedTool = tool;
                    });
                  },
                ),

                Expanded(
                  child: TacticCanvas(
                    tactic: widget.tactic,
                    selectedTool: selectedTool,
                    history: history,
                  ),
                ),
              ],
            ),
    );
  }
}