import 'package:flutter/material.dart';

class FieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final pointPaint = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.fill;

    // Borde exterior
    canvas.drawRect(
      Rect.fromLTWH(
        1,
        1,
        size.width - 2,
        size.height - 2,
      ),
      linePaint,
    );

    // Línea central
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      linePaint,
    );

    // Círculo central
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      40,
      linePaint,
    );

    // Punto central
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      3,
      pointPaint,
    );

    // Área grande superior
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.20,
        0,
        size.width * 0.60,
        90,
      ),
      linePaint,
    );

    // Área pequeña superior
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.35,
        0,
        size.width * 0.30,
        35,
      ),
      linePaint,
    );

    // Punto penalti superior
    canvas.drawCircle(
      Offset(size.width / 2, 60),
      3,
      pointPaint,
    );

    // Área grande inferior
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.20,
        size.height - 90,
        size.width * 0.60,
        90,
      ),
      linePaint,
    );

    // Área pequeña inferior
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.35,
        size.height - 35,
        size.width * 0.30,
        35,
      ),
      linePaint,
    );

    // Punto penalti inferior
    canvas.drawCircle(
      Offset(size.width / 2, size.height - 60),
      3,
      pointPaint,
    );

    // Arco superior
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, 90),
        radius: 35,
      ),
      0.25,
      2.65,
      false,
      linePaint,
    );

    // Arco inferior
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height - 90),
        radius: 35,
      ),
      3.40,
      2.65,
      false,
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}