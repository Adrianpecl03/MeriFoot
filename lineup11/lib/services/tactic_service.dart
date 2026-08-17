import 'package:hive/hive.dart';

import '../models/tactic.dart';

class TacticService {
  static final Box<Tactic> _box = Hive.box<Tactic>("tactics_v2");

  static List<Tactic> getTactics() {
    return _box.values.toList();
  }

  static Future<void> addTactic(Tactic tactic) async {
    await _box.put(tactic.id, tactic);
  }

  static Future<void> updateTactic(Tactic tactic) async {
    await _box.put(tactic.id, tactic);
  }

  static Future<void> deleteTactic(String id) async {
    await _box.delete(id);
  }

  static Future<void> deleteAllTactics() async {
    await _box.clear();
  }
}