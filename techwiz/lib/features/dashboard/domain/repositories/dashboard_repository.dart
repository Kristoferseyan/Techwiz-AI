import '../entities/quick_action.dart';
import '../entities/issue.dart';
import '../entities/guide.dart';

abstract class DashboardRepository {
  Future<List<QuickAction>> getQuickActions({String? token});
  Future<List<Issue>> getCommonIssues({String? token});
  Future<List<Guide>> getRecentGuides({String? token});
  Future<List<String>> getCategories({String? token});
  Future<List<Issue>> searchIssues(String query, {String? token});
  Future<List<Issue>> getIssuesByCategory(String category, {String? token});
}
