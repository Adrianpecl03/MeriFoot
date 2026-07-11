import '../models/player_position.dart';

class PositionMapper {
  static List<PlayerPosition> allowedPositions(String fieldPosition) {
    switch (fieldPosition) {
      case "GK":
        return [
          PlayerPosition.gk,
        ];

      case "LB":
        return [
          PlayerPosition.lb,
          PlayerPosition.lwb,
        ];

      case "RB":
        return [
          PlayerPosition.rb,
          PlayerPosition.rwb,
        ];

      case "LCB":
      case "CB":
      case "RCB":
        return [
          PlayerPosition.cb,
        ];

      case "LWB":
        return [
          PlayerPosition.lwb,
          PlayerPosition.lb,
        ];

      case "RWB":
        return [
          PlayerPosition.rwb,
          PlayerPosition.rb,
        ];

      case "CDM":
        return [
          PlayerPosition.cdm,
          PlayerPosition.cm,
        ];

      case "LCM":
      case "CM":
      case "RCM":
        return [
          PlayerPosition.cm,
          PlayerPosition.lcm,
          PlayerPosition.rcm,
          PlayerPosition.cdm,
          PlayerPosition.cam,
        ];

      case "CAM":
        return [
          PlayerPosition.cam,
          PlayerPosition.cm,
        ];

      case "LM":
        return [
          PlayerPosition.lm,
          PlayerPosition.lw,
        ];

      case "RM":
        return [
          PlayerPosition.rm,
          PlayerPosition.rw,
        ];

      case "LW":
        return [
          PlayerPosition.lw,
          PlayerPosition.lm,
        ];

      case "RW":
        return [
          PlayerPosition.rw,
          PlayerPosition.rm,
        ];

      case "LS":
      case "RS":
      case "ST":
        return [
          PlayerPosition.st,
          PlayerPosition.ls,
          PlayerPosition.rs,
        ];

      default:
        return [];
    }
  }
}