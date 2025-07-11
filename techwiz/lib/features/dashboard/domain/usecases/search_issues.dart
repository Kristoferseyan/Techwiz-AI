import '../entities/issue.dart';
import '../repositories/dashboard_repository.dart';

class SearchIssues {
  final DashboardRepository repository;

  SearchIssues(this.repository);

  Future<List<Issue>> call(String query, {String? token}) async {
    return await repository.searchIssues(query, token: token);
  }
}
