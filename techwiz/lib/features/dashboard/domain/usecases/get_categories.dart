import '../repositories/dashboard_repository.dart';

class GetCategories {
  final DashboardRepository repository;

  GetCategories(this.repository);

  Future<List<String>> call({String? token}) async {
    print(
      'GetCategories use case called with token: ${token != null ? "Present (${token.substring(0, 20)}...)" : "None"}',
    );
    return await repository.getCategories(token: token);
  }
}
