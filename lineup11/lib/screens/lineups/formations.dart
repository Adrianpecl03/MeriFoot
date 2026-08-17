import 'field_position.dart';

class Formations {
  static const Map<String, List<FieldPosition>> data = {
    // =========================
    // FÚTBOL 11
    // =========================

    "4-3-3": [
      FieldPosition(id: "POR", name: "Portero", x: 0.50, y: 0.92),
      FieldPosition(id: "LI", name: "Lateral Izquierdo", x: 0.12, y: 0.78),
      FieldPosition(id: "DFC1", name: "Central Izquierdo", x: 0.37, y: 0.75),
      FieldPosition(id: "DFC2", name: "Central Derecho", x: 0.63, y: 0.75),
      FieldPosition(id: "LD", name: "Lateral Derecho", x: 0.88, y: 0.78),
      FieldPosition(id: "MC1", name: "Interior Izquierdo", x: 0.25, y: 0.50),
      FieldPosition(id: "MC2", name: "Mediocentro", x: 0.50, y: 0.45),
      FieldPosition(id: "MC3", name: "Interior Derecho", x: 0.75, y: 0.50),
      FieldPosition(id: "EI", name: "Extremo Izquierdo", x: 0.15, y: 0.18),
      FieldPosition(id: "DC", name: "Delantero Centro", x: 0.50, y: 0.08),
      FieldPosition(id: "ED", name: "Extremo Derecho", x: 0.85, y: 0.18),
    ],

    "4-4-2": [
      FieldPosition(id: "POR", name: "Portero", x: 0.50, y: 0.92),
      FieldPosition(id: "LI", name: "Lateral Izquierdo", x: 0.12, y: 0.78),
      FieldPosition(id: "DFC1", name: "Central Izquierdo", x: 0.37, y: 0.75),
      FieldPosition(id: "DFC2", name: "Central Derecho", x: 0.63, y: 0.75),
      FieldPosition(id: "LD", name: "Lateral Derecho", x: 0.88, y: 0.78),
      FieldPosition(id: "MI", name: "Interior Izquierdo", x: 0.15, y: 0.50),
      FieldPosition(id: "MC1", name: "Mediocentro Izquierdo", x: 0.38, y: 0.48),
      FieldPosition(id: "MC2", name: "Mediocentro Derecho", x: 0.62, y: 0.48),
      FieldPosition(id: "MD", name: "Interior Derecho", x: 0.85, y: 0.50),
      FieldPosition(id: "DC1", name: "Delantero Izquierdo", x: 0.35, y: 0.14),
      FieldPosition(id: "DC2", name: "Delantero Derecho", x: 0.65, y: 0.14),
    ],

    "4-2-3-1": [
      FieldPosition(id: "POR", name: "Portero", x: 0.50, y: 0.92),
      FieldPosition(id: "LI", name: "Lateral Izquierdo", x: 0.12, y: 0.78),
      FieldPosition(id: "DFC1", name: "Central Izquierdo", x: 0.37, y: 0.75),
      FieldPosition(id: "DFC2", name: "Central Derecho", x: 0.63, y: 0.75),
      FieldPosition(id: "LD", name: "Lateral Derecho", x: 0.88, y: 0.78),
      FieldPosition(id: "MCD1", name: "Pivote Izquierdo", x: 0.38, y: 0.58),
      FieldPosition(id: "MCD2", name: "Pivote Derecho", x: 0.62, y: 0.58),
      FieldPosition(id: "MCO1", name: "Mediapunta Izquierdo", x: 0.18, y: 0.34),
      FieldPosition(id: "MCO2", name: "Mediapunta", x: 0.50, y: 0.30),
      FieldPosition(id: "MCO3", name: "Mediapunta Derecho", x: 0.82, y: 0.34),
      FieldPosition(id: "DC", name: "Delantero Centro", x: 0.50, y: 0.08),
    ],

    "4-1-4-1": [
      FieldPosition(id: "POR", name: "Portero", x: 0.50, y: 0.92),
      FieldPosition(id: "LI", name: "Lateral Izquierdo", x: 0.12, y: 0.78),
      FieldPosition(id: "DFC1", name: "Central Izquierdo", x: 0.37, y: 0.75),
      FieldPosition(id: "DFC2", name: "Central Derecho", x: 0.63, y: 0.75),
      FieldPosition(id: "LD", name: "Lateral Derecho", x: 0.88, y: 0.78),
      FieldPosition(id: "MCD", name: "Pivote", x: 0.50, y: 0.60),
      FieldPosition(id: "MI", name: "Interior Izquierdo", x: 0.15, y: 0.40),
      FieldPosition(id: "MC1", name: "Mediocentro Izquierdo", x: 0.38, y: 0.36),
      FieldPosition(id: "MC2", name: "Mediocentro Derecho", x: 0.62, y: 0.36),
      FieldPosition(id: "MD", name: "Interior Derecho", x: 0.85, y: 0.40),
      FieldPosition(id: "DC", name: "Delantero Centro", x: 0.50, y: 0.08),
    ],

    "3-5-2": [
      FieldPosition(id: "POR", name: "Portero", x: 0.50, y: 0.92),
      FieldPosition(id: "DFC1", name: "Central Izquierdo", x: 0.22, y: 0.78),
      FieldPosition(id: "DFC2", name: "Central", x: 0.50, y: 0.75),
      FieldPosition(id: "DFC3", name: "Central Derecho", x: 0.78, y: 0.78),
      FieldPosition(id: "LI", name: "Carrilero Izquierdo", x: 0.05, y: 0.50),
      FieldPosition(id: "MC1", name: "Interior Izquierdo", x: 0.28, y: 0.46),
      FieldPosition(id: "MC2", name: "Mediocentro", x: 0.50, y: 0.42),
      FieldPosition(id: "MC3", name: "Interior Derecho", x: 0.72, y: 0.46),
      FieldPosition(id: "LD", name: "Carrilero Derecho", x: 0.95, y: 0.50),
      FieldPosition(id: "DC1", name: "Delantero Izquierdo", x: 0.35, y: 0.14),
      FieldPosition(id: "DC2", name: "Delantero Derecho", x: 0.65, y: 0.14),
    ],

    "3-4-3": [
      FieldPosition(id: "POR", name: "Portero", x: 0.50, y: 0.92),
      FieldPosition(id: "DFC1", name: "Central Izquierdo", x: 0.22, y: 0.78),
      FieldPosition(id: "DFC2", name: "Central", x: 0.50, y: 0.75),
      FieldPosition(id: "DFC3", name: "Central Derecho", x: 0.78, y: 0.78),
      FieldPosition(id: "MI", name: "Interior Izquierdo", x: 0.12, y: 0.48),
      FieldPosition(id: "MC1", name: "Mediocentro Izquierdo", x: 0.38, y: 0.45),
      FieldPosition(id: "MC2", name: "Mediocentro Derecho", x: 0.62, y: 0.45),
      FieldPosition(id: "MD", name: "Interior Derecho", x: 0.88, y: 0.48),
      FieldPosition(id: "EI", name: "Extremo Izquierdo", x: 0.15, y: 0.18),
      FieldPosition(id: "DC", name: "Delantero Centro", x: 0.50, y: 0.08),
      FieldPosition(id: "ED", name: "Extremo Derecho", x: 0.85, y: 0.18),
    ],

    "5-3-2": [
      FieldPosition(id: "POR", name: "Portero", x: 0.50, y: 0.92),
      FieldPosition(id: "LI", name: "Carrilero Izquierdo", x: 0.03, y: 0.70),
      FieldPosition(id: "DFC1", name: "Central Izquierdo", x: 0.22, y: 0.78),
      FieldPosition(id: "DFC2", name: "Central", x: 0.50, y: 0.75),
      FieldPosition(id: "DFC3", name: "Central Derecho", x: 0.78, y: 0.78),
      FieldPosition(id: "LD", name: "Carrilero Derecho", x: 0.97, y: 0.70),
      FieldPosition(id: "MC1", name: "Interior Izquierdo", x: 0.25, y: 0.48),
      FieldPosition(id: "MC2", name: "Mediocentro", x: 0.50, y: 0.42),
      FieldPosition(id: "MC3", name: "Interior Derecho", x: 0.75, y: 0.48),
      FieldPosition(id: "DC1", name: "Delantero Izquierdo", x: 0.35, y: 0.14),
      FieldPosition(id: "DC2", name: "Delantero Derecho", x: 0.65, y: 0.14),
    ],

    // =========================
    // FÚTBOL 7
    // =========================

    "7 - 2-3-1": [
      FieldPosition(id: "POR", name: "Portero", x: 0.50, y: 0.92),

      FieldPosition(
        id: "DFC1",
        name: "Defensa Izquierdo",
        x: 0.28,
        y: 0.72,
      ),

      FieldPosition(
        id: "DFC2",
        name: "Defensa Derecho",
        x: 0.72,
        y: 0.72,
      ),

      FieldPosition(
        id: "MI",
        name: "Medio Izquierdo",
        x: 0.15,
        y: 0.45,
      ),

      FieldPosition(
        id: "MC",
        name: "Mediocentro",
        x: 0.50,
        y: 0.40,
      ),

      FieldPosition(
        id: "MD",
        name: "Medio Derecho",
        x: 0.85,
        y: 0.45,
      ),

      FieldPosition(
        id: "DC",
        name: "Delantero",
        x: 0.50,
        y: 0.10,
      ),
    ],

    "7 - 3-2-1": [
      FieldPosition(id: "POR", name: "Portero", x: 0.50, y: 0.92),

      FieldPosition(
        id: "DFC1",
        name: "Defensa Izquierdo",
        x: 0.20,
        y: 0.75,
      ),

      FieldPosition(
        id: "DFC2",
        name: "Defensa Central",
        x: 0.50,
        y: 0.72,
      ),

      FieldPosition(
        id: "DFC3",
        name: "Defensa Derecho",
        x: 0.80,
        y: 0.75,
      ),

      FieldPosition(
        id: "MC1",
        name: "Medio Izquierdo",
        x: 0.32,
        y: 0.45,
      ),

      FieldPosition(
        id: "MC2",
        name: "Medio Derecho",
        x: 0.68,
        y: 0.45,
      ),

      FieldPosition(
        id: "DC",
        name: "Delantero",
        x: 0.50,
        y: 0.10,
      ),
    ],

    "7 - 3-1-2": [
      FieldPosition(id: "POR", name: "Portero", x: 0.50, y: 0.92),

      FieldPosition(
        id: "DFC1",
        name: "Defensa Izquierdo",
        x: 0.20,
        y: 0.75,
      ),

      FieldPosition(
        id: "DFC2",
        name: "Defensa Central",
        x: 0.50,
        y: 0.72,
      ),

      FieldPosition(
        id: "DFC3",
        name: "Defensa Derecho",
        x: 0.80,
        y: 0.75,
      ),

      FieldPosition(
        id: "MC",
        name: "Mediocentro",
        x: 0.50,
        y: 0.48,
      ),

      FieldPosition(
        id: "DC1",
        name: "Delantero Izquierdo",
        x: 0.35,
        y: 0.15,
      ),

      FieldPosition(
        id: "DC2",
        name: "Delantero Derecho",
        x: 0.65,
        y: 0.15,
      ),
    ],

    "7 - 2-2-2": [
      FieldPosition(id: "POR", name: "Portero", x: 0.50, y: 0.92),

      FieldPosition(
        id: "DFC1",
        name: "Defensa Izquierdo",
        x: 0.28,
        y: 0.73,
      ),

      FieldPosition(
        id: "DFC2",
        name: "Defensa Derecho",
        x: 0.72,
        y: 0.73,
      ),

      FieldPosition(
        id: "MC1",
        name: "Medio Izquierdo",
        x: 0.30,
        y: 0.45,
      ),

      FieldPosition(
        id: "MC2",
        name: "Medio Derecho",
        x: 0.70,
        y: 0.45,
      ),

      FieldPosition(
        id: "DC1",
        name: "Delantero Izquierdo",
        x: 0.35,
        y: 0.15,
      ),

      FieldPosition(
        id: "DC2",
        name: "Delantero Derecho",
        x: 0.65,
        y: 0.15,
      ),
    ],
  };
}