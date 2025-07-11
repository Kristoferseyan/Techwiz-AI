import '../../domain/entities/quick_action.dart';
import '../../domain/entities/issue.dart';
import '../../domain/entities/guide.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<QuickAction> quickActions;
  final List<Issue> commonIssues;
  final List<Guide> recentGuides;
  final List<String> categories;

  DashboardLoaded({
    required this.quickActions,
    required this.commonIssues,
    required this.recentGuides,
    required this.categories,
  });
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}

class DashboardSearchLoading extends DashboardState {}

class DashboardSearchLoaded extends DashboardState {
  final List<Issue> searchResults;
  final String query;

  DashboardSearchLoaded({required this.searchResults, required this.query});
}

class DashboardCategoryLoading extends DashboardState {}

class DashboardCategoryLoaded extends DashboardState {
  final List<Issue> categoryIssues;
  final String category;

  DashboardCategoryLoaded({
    required this.categoryIssues,
    required this.category,
  });
}
