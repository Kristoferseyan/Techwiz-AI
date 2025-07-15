import 'package:techwiz/features/dashboard/data/dashboard_api_service.dart';

import '../domain/repositories/dashboard_repository.dart';
import '../domain/entities/quick_action.dart';
import '../domain/entities/guide.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardApiService apiService;

  DashboardRepositoryImpl(this.apiService);

  @override
  Future<List<QuickAction>> getQuickActions({String? token}) async {
    return await apiService.getQuickActions(token: token);
  }

  @override
  Future<List<Guide>> getRecentGuides({String? token}) async {
    return await apiService.getRecentGuides(token: token);
  }
}
