import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../models/callup.dart';

class CallupService {

  static final Box<Callup> _callupBox =
      Hive.box<Callup>("callups");

  static const Uuid _uuid = Uuid();

  static List<Callup> getCallups() {
    return _callupBox.values.toList();
  }

  static Future<void> addCallup({
    required String title,
    required String opponent,
    required DateTime date,
    required String time,
    required String field,
    required List<String> playerIds,
  }) async {

    final callup = Callup(
      id: _uuid.v4(),
      title: title,
      opponent: opponent,
      date: date,
      time: time,
      field: field,
      playerIds: playerIds,
    );

    await _callupBox.put(
      callup.id,
      callup,
    );
  }

  static Future<void> updateCallup(
    Callup callup,
  ) async {
    await callup.save();
  }

  static Future<void> deleteCallup(
    String id,
  ) async {

    final key = _callupBox.keys.firstWhere(
      (k) => _callupBox.get(k)!.id == id,
    );

    await _callupBox.delete(key);
  }

  static Future<void> deleteAll() async {
    await _callupBox.clear();
  }
}