import '../entities/issue.dart';
import '../entities/paginated_response.dart';

abstract class ProblemsRepository {
  Future<List<Issue>> getCommonIssues({String? token});

  Future<PaginatedResponse<Issue>> getPaginatedIssues({
    String? token,
    int page = 0,
    int size = 10,
  });

  Future<List<Issue>> getIssuesByCategory(String category, {String? token});
}
