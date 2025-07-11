import '../entities/issue.dart';
import '../repositories/dashboard_repository.dart';

class GetCommonIssues {
  final DashboardRepository repository;

  GetCommonIssues(this.repository);

  Future<List<Issue>> call({String? token}) async {
    return await repository.getCommonIssues(token: token);
  }
}
