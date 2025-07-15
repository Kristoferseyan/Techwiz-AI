import '../entities/quick_action.dart';
import '../entities/issue.dart';
import '../entities/guide.dart';
import '../entities/solution.dart';
import '../entities/solution_step.dart';
import '../entities/paginated_response.dart';

abstract class DashboardRepository {
  Future<List<QuickAction>> getQuickActions({String? token});
  Future<List<Issue>> getCommonIssues({String? token});
  Future<List<Guide>> getRecentGuides({String? token});
  Future<List<String>> getCategories({String? token});
  Future<List<Issue>> searchIssues(String query, {String? token});
  Future<List<Issue>> getIssuesByCategory(String category, {String? token});
  Future<List<Solution>> getSolutionsByProblemId(
    int problemId, {
    String? token,
  });
  Future<List<SolutionStep>> getSolutionStepsBySolutionId(
    int solutionId, {
    String? token,
  });
  Future<PaginatedResponse<Issue>> getPaginatedIssues({
    String? token,
    int page = 0,
    int size = 10,
  });
}
