import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Database> createTestDatabase() async {
  sqfliteFfiInit();

  final databaseFactory = databaseFactoryFfi;
  final db = await databaseFactory.openDatabase(inMemoryDatabasePath);

  // Create tables (mimic your production schema)
  await db.execute('''
    CREATE TABLE expense (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      amount REAL,
      title TEXT,
      description TEXT,
      date INTEGER,
      categoryId TEXT
    )
  ''');

  await db.execute('''
    CREATE TABLE category (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      amount REAL NOT NULL,
      colorCode INT
    )
  ''');

  return db;
}
