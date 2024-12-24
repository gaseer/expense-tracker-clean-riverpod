import 'package:expense_tracker/features/category/data/models/category_model.dart';
import 'package:expense_tracker/features/category/data/repository/category_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

import '../createTest_database.dart';

void main() {
  late Database db;
  late CategoryRepository categoryRepository;

  setUp(() async {
    db = await createTestDatabase();
    await db.execute('''
      CREATE TABLE category (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        amount REAL NOT NULL,
        colorCode INT
      )
    ''');
    categoryRepository = CategoryRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Add category and retrieve it', () async {
    // Arrange
    final category = Category(
      id: null,
      name: 'Food',
      amount: 0.0,
      colorCode: 0xFFFF0000,
    );

    await categoryRepository.addCategory(category);
    final categories = await categoryRepository.getCategories();

    expect(categories.length, 1);
    expect(categories[0].name, 'Food');
    expect(categories[0].colorCode, 0xFFFF0000);
  });

  test('Update category amount', () async {
    final category = Category(
      id: null,
      name: 'Food',
      amount: 0.0,
      colorCode: 0xFFFF0000,
    );
    await categoryRepository.addCategory(category);

    await categoryRepository.updateCategory('1', 50.0);
    final categories = await categoryRepository.getCategories();

    // Assert
    expect(categories[0].amount, 50.0);
  });
}
