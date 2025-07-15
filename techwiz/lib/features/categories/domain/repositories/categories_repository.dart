import '../entities/category.dart';

abstract class CategoriesRepository {
  Future<List<String>> getCategories({String? token});
  Future<List<Category>> getCategoriesDetailed({String? token});
}
