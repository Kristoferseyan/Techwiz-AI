import '../entities/quick_action.dart';
import '../repositories/dashboard_repository.dart';

class GetQuickActions {
  final DashboardRepository repository;

  GetQuickActions(this.repository);

  Future<List<QuickAction>> call({String? token}) async {
    return await repository.getQuickActions(token: token);
  }
}
