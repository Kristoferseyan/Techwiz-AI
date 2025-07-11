import '../entities/issue.dart';
import '../repositories/dashboard_repository.dart';

class GetIssuesByCategory {
  final DashboardRepository repository;

  GetIssuesByCategory(this.repository);

  Future<List<Issue>> call(String category, {String? token}) async {
    return await repository.getIssuesByCategory(category, token: token);
  }
}
