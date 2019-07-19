import 'package:flutter/foundation.dart';
import 'package:meshi/data/db/app_database.dart';
import 'package:meshi/data/models/recomendation.dart';
import 'package:sqflite/sqlite_api.dart';

class RecomendationDao {

  Future<Database> _db;

  RecomendationDao(AppDatabase appDatabase){
    _db = appDatabase.database;
  }

  Future<List<Recomendation>> getAll() async{
    final db = await _db;
    final result = await db.query('recomendation');
    return compute(parseList, result);
  }

  Future removeAll() async{
    final db = await _db;
    await db.delete('recomendation');
  }

  Future insertAll(List<Recomendation> recomendations) async{
    final db = await _db;
    final batch = db.batch();
    recomendations.forEach((r) {
      batch.insert("recomendation", r.toDatabase());
    });
    return await batch.commit(noResult: true);
  }

}

List<Recomendation> parseList(List<Map<String, dynamic>> json) => json.map((x) => Recomendation.fromDatabase(x)).toList();