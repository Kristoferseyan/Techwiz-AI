import '../repositories/dashboard_repository.dart';

class GetCategories {
  final DashboardRepository repository;

  GetCategories(this.repository);

  Future<List<String>> call({String? token}) async {
    return await repository.getCategories(token: token);
  }
}
