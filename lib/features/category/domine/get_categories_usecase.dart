import '../data/models/category_model.dart';
import '../data/repository/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<Category>> execute() async {
    return await repository.getCategories();
  }
}
