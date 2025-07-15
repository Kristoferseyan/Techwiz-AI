import '../entities/quick_action.dart';
import '../entities/guide.dart';

abstract class DashboardRepository {
  Future<List<QuickAction>> getQuickActions({String? token});
  Future<List<Guide>> getRecentGuides({String? token});
}
