import 'package:flutter/foundation.dart';
import 'package:meshi/data/db/app_database.dart';
import 'package:meshi/data/models/user_match.dart';
import 'package:meshi/data/models/message.dart';
import 'package:sqflite/sqlite_api.dart';

class MatchDao {

  Future<Database> _db;

  MatchDao(AppDatabase appDatabase){
    _db = appDatabase.database;
  }

  Future<List<UserMatch>> getAll() async{
    final db = await _db;
    final result = await db.query('match');
    return compute(parseList, result);
  }

  Future<List<UserMatch>> getAllSorted() async{
    final db = await _db;
    final result = await db.query('match', orderBy: 'lastDate DESC, name ASC');
    return compute(parseList, result);
  }


  Future removeAll() async{
    final db = await _db;
    await db.delete('match');
  }

  Future insertAll(List<UserMatch> matches) async{
    final db = await _db;
    final batch = db.batch();
    matches.forEach((m) {
      batch.insert("match", m.toDatabase());
    });
    return await batch.commit(noResult: true);
  }

  Future updateMatch(int matchId, Message msg) async {
    final db = await _db;
    await db.update('match', {'lastMessage':msg.content, "lastDate":msg.date.toIso8601String()}, where:'idMatch = ?', whereArgs: [matchId]);
  }

  Future clearMatch(int matchId) async{
    final db = await _db;
    final now = DateTime.now();
    await db.update('match', {'erasedDate': now.toIso8601String()}, where:'idMatch = ?', whereArgs: [matchId]);
  }

}

List<UserMatch> parseList(List<Map<String, dynamic>> json) => json.map((x) => UserMatch.fromDatabase(x)).toList();
