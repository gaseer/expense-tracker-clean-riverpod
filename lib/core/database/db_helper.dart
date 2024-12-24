import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/utils/app_constants.dart';

final databaseProvider = Provider<Database>((ref) {
  throw UnimplementedError();
});

class DBHelper {
  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'expensesDataBase.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE ${AppConstants.expenseDbName} (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL,
            title TEXT,
            description TEXT,
            date INTEGER,
            categoryId TEXT
          )
          ''',
        );

        await db.execute('''
          CREATE TABLE  ${AppConstants.categoryDbName}(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            amount REAL NOT NULL,
            colorCode INT
          )
        ''');
      },
    );
  }
}
