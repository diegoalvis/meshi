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
    CREATE TABLE IF NOT EXISTS reward(
    id INTEGER;
    name VARCHAR(255);
    description VARCHAR(255);
    value INTEGER;
    numCouples INTEGER;
    publishDate VARCHAR(255);
    validDate VARCHAR(255);
    choseDate VARCHAR(255);
    image VARCHAR(255);
    )
    ''');
  }
}
