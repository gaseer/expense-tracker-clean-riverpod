import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../expenses/data/database/db_helper.dart';
import '../../data/models/category_model.dart';
import '../../data/repository/category_repository.dart';
import '../../domine/add_category_usecase.dart';
import '../../domine/get_categories_usecase.dart';

final categoryRepositoryProvider =
    Provider((ref) => CategoryRepository(ref.watch(databaseProvider)));

final addCategoryUseCaseProvider = Provider((ref) {
  return AddCategoryUseCase(ref.read(categoryRepositoryProvider));
});

final getCategoriesUseCaseProvider = Provider((ref) {
  return GetCategoriesUseCase(ref.read(categoryRepositoryProvider));
});

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final useCase = ref.read(getCategoriesUseCaseProvider);
  return await useCase.execute();
});
