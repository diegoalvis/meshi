/*
 * Created by Diego Alvis.
 * Copyright (c) 2019 - All rights reserved.
 */
import 'package:meshi/data/models/reward.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter/foundation.dart';
import '../app_database.dart';

class RewardDao {
  Future<Database> _db;

  RewardDao(AppDatabase appDatabase) {
    _db = appDatabase.database;
  }

  Future<Reward> getReward() async {
    final db = await _db;
    final result = await db.query('reward');
    if (result.isNotEmpty)
      return compute(parse, result[0]);
    else
      return null;
  }

  Future removeAll() async {
    final db = await _db;
    await db.delete('match');
  }

  Future insertReward(Reward reward) async {
    final db = await _db;
    final batch = db.batch();
    batch.insert("reward", reward.toJson());
    return await batch.commit(noResult: true);
  }
}

Reward parse(Map<String, dynamic> json) => Reward.fromJson(json);
