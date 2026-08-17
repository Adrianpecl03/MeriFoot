import 'package:flutter/material.dart';

import '../../../models/tactic_object.dart';

class TacticObjectWidget extends StatelessWidget {
  final TacticObject object;
  final bool selected;

  const TacticObjectWidget({
    super.key,
    required this.object,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;

    switch (object.type) {
      case "player":
        child = _playerChip(
          color: const Color(0xFFE53935),
          label: object.label ?? "",
        );
        break;

      case "opponent":
        child = _playerChip(
          color: const Color(0xFF1E88E5),
          label: object.label ?? "",
        );
        break;

      case "ball":
        child = _ball();
        break;

      case "cone":
        child = _cone();
        break;

      case "goal":
        child = _goal();
        break;

      default:
        child = const SizedBox.shrink();
    }

    return Transform.rotate(
      angle: object.rotation * 3.1415926535 / 180,
      child: Transform.scale(
        scale: object.size,
        child: child,
      ),
    );
  }

  Widget _playerChip({
    required Color color,
    required String label,
  }) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: selected ? 1.08 : 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(.9),
              color,
            ],
          ),
          border: Border.all(
            color: selected ? Colors.yellow : Colors.white,
            width: selected ? 4 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(.35),
              blurRadius: 10,
              spreadRadius: 1,
            ),

            if (selected)
              BoxShadow(
                color: Colors.yellow.withOpacity(.7),
                blurRadius: 22,
                spreadRadius: 6,
              ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _ball() {
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: selected ? 1.08 : 1,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? Colors.yellow : Colors.black12,
            width: selected ? 3 : 1,
          ),
          boxShadow: [
            const BoxShadow(
              blurRadius: 6,
              color: Colors.black26,
            ),
            if (selected)
              const BoxShadow(
                blurRadius: 15,
                color: Colors.yellow,
              ),
          ],
        ),
        child: const Icon(
          Icons.sports_soccer,
          color: Colors.black,
          size: 16,
        ),
      ),
    );
  }

  Widget _cone() {
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: selected ? 1.08 : 1,
      child: CustomPaint(
        size: const Size(28, 28),
        painter: _ConePainter(selected),
      ),
    );
  }

  Widget _goal() {
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: selected ? 1.08 : 1,
      child: Container(
        width: 34,
        height: 24,
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.yellow : Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(2),
        ),
        child: CustomPaint(
          painter: _GoalPainter(),
        ),
      ),
    );
  }
}

class _ConePainter extends CustomPainter {
  final bool selected;

  _ConePainter(this.selected);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFFFB74D),
          Color(0xFFF57C00),
        ],
      ).createShader(Offset.zero & size);

    final path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);

    if (selected) {
      final border = Paint()
        ..color = Colors.yellow
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawPath(path, border);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GoalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final net = Paint()
      ..color = Colors.white30
      ..strokeWidth = 1;

    for (double x = 5; x < size.width; x += 5) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        net,
      );
    }

    for (double y = 5; y < size.height; y += 5) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        net,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}