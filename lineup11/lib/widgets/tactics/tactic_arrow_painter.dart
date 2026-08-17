import 'package:flutter/material.dart';
import '../../models/tactic_arrow.dart';

class TacticArrowPainter extends CustomPainter {
  final TacticArrow arrow;

  TacticArrowPainter(this.arrow);

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(
      arrow.startX * size.width,
      arrow.startY * size.height,
    );

    final end = Offset(
      arrow.endX * size.width,
      arrow.endY * size.height,
    );

    final paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = arrow.width
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}