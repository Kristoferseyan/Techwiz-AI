import 'package:techwiz/features/dashboard/data/dashboard_api_service.dart';
import 'package:techwiz/features/dashboard/domain/entities/guide.dart';
import 'package:techwiz/features/dashboard/domain/entities/issue.dart';
import 'package:techwiz/features/dashboard/domain/entities/quick_action.dart';
import 'package:techwiz/features/dashboard/domain/entities/solution.dart';
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

  Issue _issueFromProblemsDto(Map<String, dynamic> json) {
    return Issue(
      id: json['id']?.toString() ?? '0', // Now this will get the actual ID
      title: json['name'] ?? 'Unknown Problem',
      description: json['description'] ?? 'No description available',
      difficulty: 'Medium',
      estimatedTime: '10 min',
      rating: 4.0,
      category: json['category'] ?? 'General',
      createdAt: DateTime.now(),
    );
  }
}
