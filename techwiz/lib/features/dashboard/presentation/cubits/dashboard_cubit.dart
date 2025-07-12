import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/quick_action.dart';
import '../../domain/entities/issue.dart';
import '../../domain/entities/guide.dart';
import '../../domain/usecases/get_quick_actions.dart';
import '../../domain/usecases/get_common_issues.dart';
import '../../domain/usecases/get_recent_guides.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/search_issues.dart';
import '../../domain/usecases/get_issues_by_category.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetQuickActions getQuickActions;
  final GetCommonIssues getCommonIssues;
  final GetRecentGuides getRecentGuides;
  final GetCategories getCategories;
  final SearchIssues searchIssues;
  final GetIssuesByCategory getIssuesByCategory;

  DashboardCubit(
    DashboardState initialState, {
    required this.getQuickActions,
    required this.getCommonIssues,
    required this.getRecentGuides,
    required this.getCategories,
    required this.searchIssues,
    required this.getIssuesByCategory,
  }) : super(initialState);

  Future<void> loadDashboard({String? token}) async {
    emit(DashboardLoading());

    try {
      final results = await Future.wait([
        getQuickActions(token: token),
        getCommonIssues(token: token),
        getRecentGuides(token: token),
        getCategories(token: token),
      ]);

      emit(
        DashboardLoaded(
          quickActions: results[0] as List<QuickAction>,
          commonIssues: results[1] as List<Issue>,
          recentGuides: results[2] as List<Guide>,
          categories: results[3] as List<String>,
        ),
      );
    } catch (e) {
      emit(DashboardError('Failed to load dashboard: ${e.toString()}'));
    }
  }

  Future<void> loadIssuesByCategory(String category, {String? token}) async {
    emit(DashboardCategoryLoading());

    try {
      final issues = await getIssuesByCategory(category, token: token);

      emit(DashboardCategoryLoaded(categoryIssues: issues, category: category));
    } catch (e) {
      emit(
        DashboardError(
          'Failed to load issues for category "$category": ${e.toString()}',
        ),
      );
    }
  }

  Future<void> search(String query, {String? token}) async {
    emit(DashboardLoading());

    try {
      final issues = await searchIssues(query, token: token);

      emit(DashboardSearchLoaded(searchResults: issues, query: query));
    } catch (e) {
      emit(DashboardError('Failed to search issues: ${e.toString()}'));
    }
  }

  Future<List<Issue>> getCommonIssuesData({String? token}) async {
    return await getCommonIssues(token: token);
  }

  Future<List<Issue>> getIssuesByCategoryData(
    String category, {
    String? token,
  }) async {
    return await getIssuesByCategory(category, token: token);
  }
}
