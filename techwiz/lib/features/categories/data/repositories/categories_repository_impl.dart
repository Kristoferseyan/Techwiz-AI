import '../../domain/repositories/categories_repository.dart';
import '../../domain/entities/category.dart';
import '../categories_api_service.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesApiService apiService;

  CategoriesRepositoryImpl(this.apiService);

  @override
  Future<List<String>> getCategories({String? token}) async {
    return await apiService.getCategories(token: token);
  }

  @override
  Future<List<Category>> getCategoriesDetailed({String? token}) async {
    return await apiService.getCategoriesDetailed(token: token);
  }
}
