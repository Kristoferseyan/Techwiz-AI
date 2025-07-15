import '../../domain/entities/quick_action.dart';
import '../../domain/entities/guide.dart';
import '../../../categories/domain/entities/category.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<QuickAction> quickActions;
  final List<Guide> recentGuides;
  final List<Category> categories;

  DashboardLoaded({
    required this.quickActions,
    required this.recentGuides,
    required this.categories,
  });
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}
