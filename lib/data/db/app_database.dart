import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = await _initDatabase();
    return _db;
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'meshi.db'),
      onCreate: _onCreate,
      version: 3,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS match(
    idLocal INTEGER PRIMARY KEY,
    id INTEGER, 
    name VARCHAR(255), 
    images VARCHAR(555),
    lastMessage TEXT, 
    idMatch INTEGER,
    lastDate VARCHAR(255),
    type VARCHAR(70),
    state VARCHAR(70),
    erasedDate VARCHAR(255)
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS message(
    idLocal INTEGER PRIMARY KEY,
    id INTEGER,
    content TEXT,
    date VARCHAR(255),
    fromUser INTEGER,
    toUser INTEGER,
    matchId INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS recomendation(
    idLocal INTEGER PRIMARY KEY,
    id INTEGER,
    type VARCHAR(200),
    name VARCHAR(255),
    description TEXT,
    freeTime TEXT,
    occupation TEXT,
    interests TEXT,
    score INTEGER,
    gender VARCHAR(50),
    images VARCHAR(555),
    similarity TEXT
    )
    ''');

  }
}