import 'package:sqflite/sqflite.dart';

import '../../../../core/utils/app_constants.dart';
import '../models/expense_model.dart';

class ExpenseRepository {
  final Database _database;

  ExpenseRepository(this._database);

  Future<List<Expense>> getAllExpenses() async {
    final maps = await _database.query(AppConstants.expenseDbName);
    return maps.isNotEmpty
        ? maps.map((map) => Expense.fromMap(map)).toList()
        : [];
  }

  Future<void> addExpense(Expense expense) async {
    await _database.insert(
      AppConstants.expenseDbName,
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateExpense(Expense expense) async {
    await _database.update(
      AppConstants.expenseDbName,
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<void> deleteExpense(int id) async {
    await _database.delete(
      AppConstants.expenseDbName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
