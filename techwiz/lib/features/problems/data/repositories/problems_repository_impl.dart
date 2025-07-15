import '../../domain/repositories/problems_repository.dart';
import '../../domain/entities/issue.dart';
import '../../domain/entities/paginated_response.dart';
import '../problems_api_service.dart';

class ProblemsRepositoryImpl implements ProblemsRepository {
  final ProblemsApiService apiService;

  ProblemsRepositoryImpl(this.apiService);

  @override
  Future<List<Issue>> getCommonIssues({String? token}) async {
    return await apiService.getCommonIssues(token: token);
  }

  @override
  Future<PaginatedResponse<Issue>> getPaginatedIssues({
    String? token,
    int page = 0,
    int size = 10,
  }) async {
    return await apiService.getPaginatedIssues(
      token: token,
      page: page,
      size: size,
    );
  }

  @override
  Future<List<Issue>> getIssuesByCategory(
    String category, {
    String? token,
  }) async {
    return await apiService.getIssuesByCategory(category, token: token);
  }
}
