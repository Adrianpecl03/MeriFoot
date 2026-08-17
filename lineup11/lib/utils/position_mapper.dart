import '../models/player_position.dart';

class PositionMapper {
  static List<PlayerPosition> allowedPositions(String fieldPosition) {
    switch (fieldPosition) {

      // ============================================================
      // PORTERO
      // ============================================================

      case "POR":
        return [
          PlayerPosition.por,
        ];

      // ============================================================
      // DEFENSA
      // ============================================================

      case "LI":
      case "LTI":
      case "CARRILERO_IZQ":
        return [
          PlayerPosition.li,
        ];

      case "LD":
      case "LTD":
      case "CARRILERO_DER":
        return [
          PlayerPosition.ld,
        ];

      case "DFC":
      case "DFC1":
      case "DFC2":
      case "DFC3":
      case "CENTRAL":
      case "CENTRAL1":
      case "CENTRAL2":
      case "CENTRAL3":
        return [
          PlayerPosition.dfc,
        ];

      // ============================================================
      // MEDIOCENTRO DEFENSIVO
      // ============================================================

      case "MCD":
      case "MCD1":
      case "MCD2":
      case "PIVOTE":
        return [
          PlayerPosition.mcd,
          PlayerPosition.mc,
        ];

      // ============================================================
      // MEDIOCENTRO
      // ============================================================

      case "MC":
      case "MC1":
      case "MC2":
      case "MC3":
      case "MEDIO":
      case "MEDIO1":
      case "MEDIO2":
      case "MEDIO3":
        return [
          PlayerPosition.mc,
          PlayerPosition.mcd,
          PlayerPosition.mco,
        ];

      // ============================================================
      // MEDIAPUNTA
      // ============================================================

      case "MCO":
      case "MCO1":
      case "MCO2":
      case "MCO3":
      case "MEDIAPUNTA":
        return [
          PlayerPosition.mco,
          PlayerPosition.mc,
        ];

      // ============================================================
      // BANDA IZQUIERDA
      // ============================================================

      case "MI":
      case "MI1":
      case "INTERIOR_IZQ":
        return [
          PlayerPosition.mi,
          PlayerPosition.ei,
        ];

      case "EI":
      case "EI1":
      case "EXTREMO_IZQ":
        return [
          PlayerPosition.ei,
          PlayerPosition.mi,
        ];

      // ============================================================
      // BANDA DERECHA
      // ============================================================

      case "MD":
      case "MD1":
      case "INTERIOR_DER":
        return [
          PlayerPosition.md,
          PlayerPosition.ed,
        ];

      case "ED":
      case "ED1":
      case "EXTREMO_DER":
        return [
          PlayerPosition.ed,
          PlayerPosition.md,
        ];

      // ============================================================
      // DELANTERO
      // ============================================================

      case "DC":
      case "DC1":
      case "DC2":
      case "DEL":
      case "DEL1":
      case "DEL2":
      case "DELANTERO":
        return [
          PlayerPosition.dc,
        ];

      // ============================================================
      // FÚTBOL 7 - POSICIONES GENÉRICAS
      // ============================================================

      // Defensa de F7 que puede ser lateral o central
      case "DEF":
      case "DEF1":
      case "DEF2":
      case "DEF3":
        return [
          PlayerPosition.dfc,
          PlayerPosition.li,
          PlayerPosition.ld,
        ];

      // Medio de F7
      case "MED":
      case "MED1":
      case "MED2":
      case "MED3":
        return [
          PlayerPosition.mc,
          PlayerPosition.mcd,
          PlayerPosition.mco,
        ];

      // ============================================================
      // POSICIONES DESCONOCIDAS
      // ============================================================

      default:
        return [];
    }
  }
}