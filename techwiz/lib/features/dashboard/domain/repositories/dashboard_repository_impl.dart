import 'package:techwiz/features/dashboard/data/dashboard_api_service.dart';
import 'package:techwiz/features/dashboard/domain/entities/guide.dart';
import 'package:techwiz/features/dashboard/domain/entities/issue.dart';
import 'package:techwiz/features/dashboard/domain/entities/paginated_response.dart';
import 'package:techwiz/features/dashboard/domain/entities/quick_action.dart';
import 'package:techwiz/features/dashboard/domain/entities/solution.dart';
import 'package:techwiz/features/dashboard/domain/entities/solution_step.dart';
import 'package:techwiz/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardApiService apiService;

  DashboardRepositoryImpl(this.apiService);

  @override
  Future<List<QuickAction>> getQuickActions({String? token}) async {
    return await apiService.getQuickActions(token: token);
  }

  @override
  Future<List<Issue>> getCommonIssues({String? token}) async {
    return await apiService.getCommonIssues(token: token);
  }

  @override
  Future<List<Guide>> getRecentGuides({String? token}) async {
    return await apiService.getRecentGuides(token: token);
  }

  @override
  Future<List<String>> getCategories({String? token}) async {
    return await apiService.getCategories(token: token);
  }

  @override
  Future<List<Issue>> searchIssues(String query, {String? token}) async {
    return await apiService.searchIssues(query, token: token);
  }

  @override
  Future<List<Issue>> getIssuesByCategory(
    String category, {
    String? token,
  }) async {
    return await apiService.getIssuesByCategory(category, token: token);
  }

  @override
  Future<List<Solution>> getSolutionsByProblemId(
    int problemId, {
    String? token,
  }) async {
    return await apiService.getSolutionsByProblemId(problemId, token: token);
  }

  @override
  Future<List<SolutionStep>> getSolutionStepsBySolutionId(
    int solutionId, {
    String? token,
  }) async {
    return await apiService.getSolutionStepsBySolutionId(
      solutionId,
      token: token,
    );
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
}
