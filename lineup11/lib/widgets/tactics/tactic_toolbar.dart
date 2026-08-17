import 'package:flutter/material.dart';

class TacticToolbar extends StatelessWidget {
  final bool vertical;
  final String selectedTool;
  final ValueChanged<String> onToolSelected;

  const TacticToolbar({
    super.key,
    required this.vertical,
    required this.selectedTool,
    required this.onToolSelected,
  });

  @override
  Widget build(BuildContext context) {
    final tools = <_ToolItem>[
      _ToolItem("select", "Seleccionar",Icons.open_with),
      _ToolItem("player", "Jugador",Icons.circle),
      _ToolItem("opponent","Rival", Icons.circle_outlined),
      _ToolItem("ball", "Pelota", Icons.sports_soccer),
      _ToolItem("cone", "Cono",Icons.change_history),
      _ToolItem("goal","Porteria", Icons.sports),
      _ToolItem("arrow","Flechas", Icons.trending_flat),
      _ToolItem("draw","Dibujar", Icons.edit),
      _ToolItem("delete", "Eliminar",Icons.delete),
      _ToolItem("play", "Reproducir",Icons.play_arrow),
    ];

    return Container(
      width: vertical ? 82 : double.infinity,
      height: vertical ? double.infinity : 82,
      color: const Color(0xFF161F34),
      child: vertical
          ? SingleChildScrollView(
              child: Column(
                children: tools.map(_buildButton).toList(),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tools.map(_buildButton).toList(),
              ),
            ),
    );
  }

  Widget _buildButton(_ToolItem tool) {
    final selected = selectedTool == tool.id;

    return Padding(
      padding: const EdgeInsets.all(6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF22C55E)
              : const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
        child: IconButton(
          tooltip: tool.label,
          color: Colors.white,
          icon: Icon(tool.icon),
          onPressed: () {
            if (selected) {
              onToolSelected("select");
            } else {
              onToolSelected(tool.id);
            }
          },
        ),
      ),
    );
  }
}

class _ToolItem {
  final String id;
  final String label;
  final IconData icon;

  const _ToolItem(this.id,this.label, this.icon);
}