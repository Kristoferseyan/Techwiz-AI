import '../repositories/dashboard_repository.dart';
import '../entities/paginated_response.dart';
import '../entities/issue.dart';

class GetPaginatedIssues {
  final DashboardRepository repository;

  GetPaginatedIssues(this.repository);

  Future<PaginatedResponse<Issue>> call({
    String? token,
    int page = 0,
    int size = 10,
  }) async {
    return await repository.getPaginatedIssues(
      token: token,
      page: page,
      size: size,
    );
  }
}
