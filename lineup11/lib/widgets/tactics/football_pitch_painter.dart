import 'package:flutter/material.dart';

class FootballPitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final field = Rect.fromLTWH(0, 0, size.width, size.height);

    // Césped
    final grass = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2E8B57),
          Color(0xFF267347),
        ],
      ).createShader(field);

    canvas.drawRRect(
      RRect.fromRectAndRadius(field, const Radius.circular(20)),
      grass,
    );

    // Franjas del césped
    final stripePaint = Paint()..color = Colors.white.withOpacity(0.05);

    const stripes = 10;

    for (int i = 0; i < stripes; i++) {
      if (i.isEven) {
        canvas.drawRect(
          Rect.fromLTWH(
            0,
            i * size.height / stripes,
            size.width,
            size.height / stripes,
          ),
          stripePaint,
        );
      }
    }

    final line = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Línea exterior
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(2, 2, size.width - 4, size.height - 4),
        const Radius.circular(20),
      ),
      line,
    );

    // Línea de medio campo
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      line,
    );

    // Círculo central
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.13,
      line,
    );

    // Punto central
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      3,
      Paint()..color = Colors.white,
    );

    final areaWidth = size.width * 0.55;
    final areaHeight = size.height * 0.16;

    final smallWidth = size.width * 0.25;
    final smallHeight = size.height * 0.07;

    // Área superior
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, areaHeight / 2),
        width: areaWidth,
        height: areaHeight,
      ),
      line,
    );

    // Área inferior
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height - areaHeight / 2),
        width: areaWidth,
        height: areaHeight,
      ),
      line,
    );

    // Área pequeña superior
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, smallHeight / 2),
        width: smallWidth,
        height: smallHeight,
      ),
      line,
    );

    // Área pequeña inferior
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height - smallHeight / 2),
        width: smallWidth,
        height: smallHeight,
      ),
      line,
    );

    // Punto de penalti superior
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.11),
      3,
      Paint()..color = Colors.white,
    );

    // Punto de penalti inferior
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.89),
      3,
      Paint()..color = Colors.white,
    );

    // Arco del área superior
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height * 0.11),
        radius: size.width * 0.12,
      ),
      0.25,
      2.64,
      false,
      line,
    );

    // Arco del área inferior
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height * 0.89),
        radius: size.width * 0.12,
      ),
      3.39,
      2.64,
      false,
      line,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}