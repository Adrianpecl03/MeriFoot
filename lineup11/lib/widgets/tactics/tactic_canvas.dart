import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../models/tactic.dart';
import '../../models/tactic_object.dart';
import 'football_pitch_painter.dart';
import 'tactic_object_widget.dart';
import '../../services/tactic_history_service.dart';
import 'arrow_preview_painter.dart';
import '../../models/tactic_arrow.dart';
import 'arrow_preview_painter.dart';

class TacticCanvas extends StatefulWidget {
  final Tactic tactic;
  final String selectedTool;
  final TacticHistoryService history;

  const TacticCanvas({
    super.key,
    required this.tactic,
    required this.selectedTool,
    required this.history
  });

  @override
  State<TacticCanvas> createState() => _TacticCanvasState();
}

class _TacticCanvasState extends State<TacticCanvas> {
  final Uuid _uuid = const Uuid();

  double? dragStartX;
  double? dragStartY;
  double? initialScale;
  Offset? arrowStart;
  Offset? arrowCurrent;
  Offset? lastFocalPoint;
  String? selectedArrowId;

  String? selectedObjectId;

  TacticObject? get selectedObject {
    if (selectedObjectId == null) return null;

    try {
      return widget.tactic.objects.firstWhere(
        (e) => e.id == selectedObjectId,
      );
    } catch (_) {
      return null;
    }
  }

  void _addObject(
    String type,
    double x,
    double y,
  ) {
    String color = "red";
    String? label;

    switch (type) {
      case "player":
        color = "red";
        label =
            "${widget.tactic.objects.where((e) => e.type == "player").length + 1}";
        break;

      case "opponent":
        color = "blue";
        label =
            "${widget.tactic.objects.where((e) => e.type == "opponent").length + 1}";
        break;

      case "ball":
        color = "white";
        break;

      case "cone":
        color = "orange";
        break;

      case "goal":
        color = "white";
        break;
    }

    final object = TacticObject(
      id: _uuid.v4(),
      type: type,
      x: x.clamp(.03, .97),
      y: y.clamp(.03, .97),
      color: color,
      label: label,
    );

    setState(() {
      widget.tactic.objects.add(object);
      selectedObjectId = object.id;
    });
    widget.history.addAction(
      HistoryAction(
        type: HistoryActionType.create,
        object: object.copy(),
      ),
    );
    widget.tactic.save();
  }

  void _deleteObject(TacticObject object) {
    widget.history.addAction(
      HistoryAction(
        type: HistoryActionType.delete,
        object: object.copy(),
      ),
    );
    setState(() {
      widget.tactic.objects.remove(object);

      if (selectedObjectId == object.id) {
        selectedObjectId = null;
      }
    });
    widget.tactic.save();
  }

  TacticArrow? _findArrowAtPoint(
    Offset point,
    double width,
    double height,
  ) {
    const double hitDistance = 18;

    // Recorremos al revés para seleccionar primero
    // la flecha que está más arriba.
    for (final arrow in widget.tactic.arrows.reversed) {
      final start = Offset(
        arrow.startX * width,
        arrow.startY * height,
      );

      final end = Offset(
        arrow.endX * width,
        arrow.endY * height,
      );

      final distance = _distanceToSegment(
        point,
        start,
        end,
      );

      if (distance <= hitDistance) {
        return arrow;
      }
    }

    return null;
  }
  
  double _distanceToSegment(
    Offset point,
    Offset start,
    Offset end,
  ) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;

    if (dx == 0 && dy == 0) {
      return (point - start).distance;
    }

    final t = (
      ((point.dx - start.dx) * dx) +
      ((point.dy - start.dy) * dy)
    ) / (dx * dx + dy * dy);

    final clampedT = t.clamp(0.0, 1.0);

    final projection = Offset(
      start.dx + clampedT * dx,
      start.dy + clampedT * dy,
    );

    return (point - projection).distance;
  }

  void _deleteArrow(TacticArrow arrow) {
    widget.history.addAction(
      HistoryAction(
        type: HistoryActionType.delete,
        arrow: arrow.copy(),
      ),
    );

    setState(() {
      widget.tactic.arrows.removeWhere(
        (e) => e.id == arrow.id,
      );

      if (selectedArrowId == arrow.id) {
        selectedArrowId = null;
      }
    });

    widget.tactic.save();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: AspectRatio(
          aspectRatio: 68 / 105,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;

              return GestureDetector(
                behavior: HitTestBehavior.opaque,

                onTapUp: (details) {
                  final x = details.localPosition.dx / width;
                  final y = details.localPosition.dy / height;

                  // =========================
                  // BORRAR
                  // =========================

                  if (widget.selectedTool == "delete") {
                    final arrow = _findArrowAtPoint(
                      details.localPosition,
                      width,
                      height,
                    );

                    if (arrow != null) {
                      _deleteArrow(arrow);
                      return;
                    }

                    return;
                  }

                  // =========================
                  // SELECCIONAR
                  // =========================

                  if (widget.selectedTool == "select") {
                    final arrow = _findArrowAtPoint(
                      details.localPosition,
                      width,
                      height,
                    );

                    if (arrow != null) {
                      setState(() {
                        selectedArrowId =
                            selectedArrowId == arrow.id ? null : arrow.id;

                        selectedObjectId = null;
                      });

                      return;
                    }

                    setState(() {
                      selectedObjectId = null;
                      selectedArrowId = null;
                    });

                    return;
                  }

                  // =========================
                  // CREAR OBJETOS
                  // =========================

                  const creationTools = {
                    "player",
                    "opponent",
                    "ball",
                    "cone",
                    "goal",
                  };

                  if (creationTools.contains(widget.selectedTool)) {
                    _addObject(
                      widget.selectedTool,
                      x,
                      y,
                    );
                  }
                },
                onScaleStart: (details) {
                  lastFocalPoint = details.localFocalPoint;

                  if (widget.selectedTool == "arrow") {
                    arrowStart = details.localFocalPoint;
                    arrowCurrent = details.localFocalPoint;

                    setState(() {});
                    return;
                  }

                  if (widget.selectedTool != "select") return;

                  final object = selectedObject;

                  if (object == null) return;
                  dragStartX = object.x;
                  dragStartY = object.y;

                  initialScale = object.size;
                },
                onScaleUpdate: (details) {
                  if (widget.selectedTool == "arrow") {
                    setState(() {
                      arrowCurrent = details.localFocalPoint;
                    });

                    return;
                  }

                  if (widget.selectedTool != "select") return;

                  final object = selectedObject;

                  if (object == null) return;

                  // Dos dedos -> cambiar tamaño
                  if (details.pointerCount >= 2) {
                    if (initialScale != null) {
                      setState(() {
                        object.size =
                            (initialScale! * details.scale).clamp(0.5, 3.0);
                      });
                    }

                    return;
                  }

                  // Un dedo -> mover
                  if (lastFocalPoint != null) {
                    final delta = details.localFocalPoint - lastFocalPoint!;

                    setState(() {
                      object.x += delta.dx / width;
                      object.y += delta.dy / height;

                      object.x = object.x.clamp(.03, .97);
                      object.y = object.y.clamp(.03, .97);
                    });
                  }

                  lastFocalPoint = details.localFocalPoint;
                },
                onScaleEnd: (_) async {
                  lastFocalPoint = null;
                  initialScale = null;

                  if (widget.selectedTool == "arrow") {
                    if (arrowStart != null && arrowCurrent != null) {
                      final arrow = TacticArrow(
                        id: _uuid.v4(),
                        startX: arrowStart!.dx / width,
                        startY: arrowStart!.dy / height,
                        endX: arrowCurrent!.dx / width,
                        endY: arrowCurrent!.dy / height,
                      );

                      setState(() {
                        widget.tactic.arrows.add(arrow);
                        selectedArrowId = arrow.id;

                        arrowStart = null;
                        arrowCurrent = null;
                      });

                      widget.history.addAction(
                        HistoryAction(
                          type: HistoryActionType.create,
                          arrow: arrow.copy(),
                        ),
                      );

                      await widget.tactic.save();
                    }
                  }
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: FootballPitchPainter(),
                      ),
                    ),
                   Positioned.fill(
                      child: IgnorePointer(
                        child: CustomPaint(
                          painter: _SavedArrowsPainter(
                                      widget.tactic.arrows,
                                      selectedArrowId,
                                    ),
                        ),
                      ),
                    ),

                    if (arrowStart != null && arrowCurrent != null)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: ArrowPreviewPainter(
                              start: arrowStart!,
                              end: arrowCurrent!,
                            ),
                          ),
                        ),
                    ),
                    ...(() {
                       final objects = [...widget.tactic.objects];
                        objects.sort((a, b) {
                          if (a.id == selectedObjectId) return 1;
                          if (b.id == selectedObjectId) return -1;
                          return 0;
                        });
                      return objects.map((object) {
                        return Positioned(
                          left: object.x * width - 21,
                          top: object.y * height - 21,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,

                            onTap: () {
                              // Herramienta borrar
                              if (widget.selectedTool == "delete") {
                                _deleteObject(object);
                                return;
                              }

                              // Solo se puede seleccionar en modo Select
                              if (widget.selectedTool != "select") {
                                return;
                              }

                              setState(() {
                                if (selectedObjectId == object.id) {
                                  selectedObjectId = null;
                                } else {
                                  selectedObjectId = object.id;
                                }
                              });
                            },

                            child: TacticObjectWidget(
                              object: object,
                              selected: selectedObjectId == object.id,
                            ),
                          ),
                        );
                      }).toList();
                    })(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );

    
  }
}

class _SavedArrowsPainter extends CustomPainter {
  final List<TacticArrow> arrows;
  final String? selectedArrowId;

  _SavedArrowsPainter(
    this.arrows,
    this.selectedArrowId,
  );

  @override
  void paint(Canvas canvas, Size size) {
    for (final arrow in arrows) {
      final start = Offset(
        arrow.startX * size.width,
        arrow.startY * size.height,
      );

      final end = Offset(
        arrow.endX * size.width,
        arrow.endY * size.height,
      );

      final selected = arrow.id == selectedArrowId;

      final paint = Paint()
        ..color = selected ? Colors.yellow : Colors.yellow
        ..strokeWidth = selected
            ? arrow.width + 3
            : arrow.width
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(start, end, paint);

      final angle = (end - start).direction;

      const arrowSize = 14.0;

      final p1 =
          end - Offset.fromDirection(angle - .45, arrowSize);

      final p2 =
          end - Offset.fromDirection(angle + .45, arrowSize);

      canvas.drawLine(end, p1, paint);
      canvas.drawLine(end, p2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}