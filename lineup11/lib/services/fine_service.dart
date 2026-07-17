import 'package:hive/hive.dart';
import '../models/fine.dart';

class FineService {
  static final Box<Fine> _box = Hive.box<Fine>('fines');

  static List<Fine> getFines() {
    return _box.values.toList();
  }

  static Future<void> addFine(Fine fine) async {
    await _box.put(fine.id, fine);
  }

  static Future<void> updateFine(Fine fine) async {
    await _box.put(fine.id, fine);
  }

  static Future<void> deleteFine(String id) async {
    await _box.delete(id);
  }

  static Future<void> deleteAllFines() async {
    await _box.clear();
  }
}