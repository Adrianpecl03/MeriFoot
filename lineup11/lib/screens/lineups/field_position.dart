import 'package:flutter/material.dart';

class FieldPosition {
  final String id;
  final String name;
  final double x;
  final double y;

  const FieldPosition({
    required this.id,
    required this.name,
    required this.x,
    required this.y,
  });

  Alignment get alignment {
    return Alignment(
      x * 2 - 1,
      y * 2 - 1,
    );
  }
}