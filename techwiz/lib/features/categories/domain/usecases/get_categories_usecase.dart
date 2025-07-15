import '../repositories/categories_repository.dart';

class GetCategoriesUseCase {
  final CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<String>> call({String? token}) async {
    return await repository.getCategories(token: token);
  }
}
