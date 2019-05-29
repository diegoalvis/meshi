import 'package:flutter/foundation.dart';
import 'package:meshi/data/models/match.dart';
import 'package:meshi/data/models/message.dart';
import 'package:sqflite/sqlite_api.dart';

import '../app_database.dart';

class MatchDao {

  Future<Database> _db;

  MatchDao(AppDatabase appDatabase){
    _db = appDatabase.database;
  }

  Future<List<Matches>> getAll() async{
    final db = await _db;
    final result = await db.query('match');
    return compute(parseList, result);
  }

  Future removeAll() async{
    final db = await _db;
    await db.delete('match');
  }

  Future insertAll(List<Matches> matches) async{
    final db = await _db;
    final batch = db.batch();
    matches.forEach((m) {
      batch.insert("match", m.toJson());
    });
    return await batch.commit(noResult: true);
  }

  Future updateMatch(int matchId, Message msg) async {
    final db = await _db;
    await db.update('match', {'lastMessage':msg.content, "lastDate":msg.date.toIso8601String()}, where:'matchId = ?', whereArgs: [matchId]);
  }

}

List<Matches> parseList(List<Map<String, dynamic>> json) =>
    json.map((x) => Matches.fromJson(x)).toList();