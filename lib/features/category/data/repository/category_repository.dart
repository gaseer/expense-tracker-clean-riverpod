import 'package:sqflite/sqflite.dart';

import '../../../../core/utils/app_constants.dart';
import '../models/category_model.dart';

class CategoryRepository {
  final Database _database;

  CategoryRepository(this._database);

  Future<void> addCategory(Category category) async {
    final db = _database;
    await db.insert(AppConstants.categoryDbName, category.toMap());
  }

  Future<void> updateCategory(String categoryId, double amount) async {
    final db = _database;
    await db.rawUpdate(
      '''
    UPDATE ${AppConstants.categoryDbName}
    SET amount = amount + ?
    WHERE id = ?
    ''',
      [amount, categoryId],
    );
  }

  Future<List<Category>> getCategories() async {
    final db = _database;
    final maps = await db.query(AppConstants.categoryDbName);
    return (maps.isNotEmpty)
        ? List.generate(maps.length, (i) => Category.fromMap(maps[i]))
        : [];
  }
}
