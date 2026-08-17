import 'package:flutter/material.dart';

class ArrowPreviewPainter extends CustomPainter {
  final Offset start;
  final Offset end;

  ArrowPreviewPainter({
    required this.start,
    required this.end,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(start, end, paint);

    final angle = (end - start).direction;

    const arrowSize = 14.0;

    final p1 = end -
        Offset.fromDirection(
          angle - 0.45,
          arrowSize,
        );

    final p2 = end -
        Offset.fromDirection(
          angle + 0.45,
          arrowSize,
        );

    canvas.drawLine(end, p1, paint);
    canvas.drawLine(end, p2, paint);
  }

  @override
  bool shouldRepaint(covariant ArrowPreviewPainter oldDelegate) => true;
}