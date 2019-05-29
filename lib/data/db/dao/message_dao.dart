import 'package:flutter/foundation.dart';
import 'package:meshi/data/db/app_database.dart';
import 'package:meshi/data/models/message.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class MessageDao {
  Future<Database> _db;

  MessageDao(AppDatabase appDatabase) {
    _db = appDatabase.database;
  }

  Future<List<Message>> get(int matchId) async {
    final db = await _db;
    final result = await db.query(
      'message',
      where: 'matchId = ?',
      whereArgs: [matchId],
      orderBy: 'date DESC'
    );
    return compute(parseList, result);
  }

  Future removeAll(int matchId) async {
    final db = await _db;
    await db.delete('message', where: 'matchId = ?', whereArgs: [matchId]);
  }

  Future<int> insert(Message message) async {
    final db = await _db;
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM message WHERE matchId = ${message.matchId}'));
    if(count == 60){
      await db.rawDelete('DELETE FROM message WHERE matchId = ${message.matchId} ORDER BY date ASC LIMIT 1');
    }
    return await db.insert('message', message.toJson());
  }

  Future insertAll(List<Message> messages) async{
    final db = await _db;
    final batch = db.batch();
    messages.forEach((m) {
      batch.insert("message", m.toJson());
    });
    return await batch.commit(noResult: true);
  }
}

List<Message> parseList(List<Map<String, dynamic>> json) =>
    json.map((x) => Message.fromJson(x)).toList();
