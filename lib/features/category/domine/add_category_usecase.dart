import '../data/models/category_model.dart';
import '../data/repository/category_repository.dart';

class AddCategoryUseCase {
  final CategoryRepository repository;

  AddCategoryUseCase(this.repository);

  Future<void> execute(Category category) async {
    await repository.addCategory(category);
  }
}
