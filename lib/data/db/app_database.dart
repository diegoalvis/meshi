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
      join(await getDatabasesPath(), 'oneparking.db'),
      onCreate: _onCreate,
      version: 2,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS vehicle(
    id INTEGER PRIMARY KEY, 
    plate VARCHAR(10), 
    brand VARCHAR(25),
    type VARCHAR(25), 
    selected BOOLEAN DEFAULT 0
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS zone(
    id INTEGER PRIMARY KEY,
    idZone VARCHAR(555), 
    type VARCHAR(60), 
    code VARCHAR(60),
    name TEXT,
    address TEXT,
    lat DOUBLE,
    lon DOUBLE
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS config(
    id INTEGER PRIMARY KEY, 
    userVehicles INTEGER,
    basePrice INTEGER,
    fractionPrice INTEGER,
    mcBasePrice INTEGER,
    mcFractionPrice INTEGER,
    baseTime INTEGER,
    fractionTime INTEGER,
    limitTime INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS schedule(
    id INTEGER PRIMARY KEY, 
    type TEXT,
    mo BOOLEAN DEFAULT 0,
    tu BOOLEAN DEFAULT 0,
    we BOOLEAN DEFAULT 0,
    th BOOLEAN DEFAULT 0,
    fr BOOLEAN DEFAULT 0,
    sa BOOLEAN DEFAULT 0,
    su BOOLEAN DEFAULT 0,
    initTime INTEGER,
    endTime INTEGER 
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS event(
    id INTEGER PRIMARY KEY, 
    fromDate VARCHAR(255),
    toDate VARCHAR(255),
    name TEXT,
    type TEXT,
    zones TEXT,
    allZones BOOLEAN
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS eventzone(
    id INTEGER PRIMARY KEY, 
    event INT,
    idZone TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS reserve(
    id INTEGER PRIMARY KEY,
    idReserve VARCHAR(355), 
    date VARCHAR(255), 
    plate VARCHAR(25),
    type VARCHAR(25),
    name VARCHAR(255),
    address VARCHAR(255)    
    )
    ''');
  }
}
