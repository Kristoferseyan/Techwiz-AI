import '../repositories/dashboard_repository.dart';
import '../entities/quick_action.dart';

class GetQuickActionsUseCase {
  final DashboardRepository repository;

  GetQuickActionsUseCase(this.repository);

  Future<List<QuickAction>> call({String? token}) async {
    return await repository.getQuickActions(token: token);
  }
}
