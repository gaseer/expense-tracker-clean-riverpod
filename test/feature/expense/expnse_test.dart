import 'package:expense_tracker/features/expenses/data/models/expense_model.dart';
import 'package:expense_tracker/features/expenses/data/repository/expense_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

import '../createTest_database.dart';

void main() {
  late Database db;
  late ExpenseRepository expenseRepository;

  setUp(() async {
    db = await createTestDatabase();
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
    expenseRepository = ExpenseRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Add expense and retrieve it', () async {
    // Arrange
    final expense = Expense(
      id: null,
      amount: 50.0,
      title: 'Lunch',
      description: 'Lunch at a restaurant',
      date: DateTime.now(),
      categoryId: '1',
    );

    // Act
    await expenseRepository.addExpense(expense);
    final expenses = await expenseRepository.getAllExpenses();

    // Assert
    expect(expenses.length, 1);
    expect(expenses[0].title, 'Lunch');
    expect(expenses[0].amount, 50.0);
  });

  test('Update an expense', () async {
    // Arrange
    final expense = Expense(
      id: null,
      amount: 50.0,
      title: 'Lunch',
      description: 'Lunch at a restaurant',
      date: DateTime.now(),
      categoryId: '1',
    );
    await expenseRepository.addExpense(expense);

    final updatedExpense = Expense(
      id: 1,
      amount: 75.0,
      title: 'Dinner',
      description: 'Dinner at a restaurant',
      date: expense.date,
      categoryId: '1',
    );

    // Act
    await expenseRepository.updateExpense(updatedExpense);
    final expenses = await expenseRepository.getAllExpenses();

    // Assert
    expect(expenses[0].title, 'Dinner');
    expect(expenses[0].amount, 75.0);
  });

  test('Delete an expense', () async {
    // Arrange
    final expense = Expense(
      id: null,
      amount: 50.0,
      title: 'Lunch',
      description: 'Lunch at a restaurant',
      date: DateTime.now(),
      categoryId: '1',
    );
    await expenseRepository.addExpense(expense);

    // Act
    await expenseRepository.deleteExpense(1);
    final expenses = await expenseRepository.getAllExpenses();

    // Assert
    expect(expenses.isEmpty, true);
  });
}
