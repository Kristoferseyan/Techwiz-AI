import '../repositories/categories_repository.dart';
import '../entities/category.dart';

class GetCategoriesDetailedUseCase {
  final CategoriesRepository repository;

  GetCategoriesDetailedUseCase(this.repository);

  Future<List<Category>> call({String? token}) async {
    return await repository.getCategoriesDetailed(token: token);
  }
}
