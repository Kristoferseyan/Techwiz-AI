import 'package:techwiz/features/dashboard/data/dashboard_api_service.dart';
import 'package:techwiz/features/dashboard/domain/entities/guide.dart';
import 'package:techwiz/features/dashboard/domain/entities/quick_action.dart';
import 'package:techwiz/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardApiService apiService;

  DashboardRepositoryImpl(this.apiService);

  @override
  Future<List<QuickAction>> getQuickActions({String? token}) async {
    return await apiService.getQuickActions(token: token);
  }

  @override
  Future<List<Guide>> getRecentGuides({String? token}) {
    // TODO: implement getRecentGuides
    throw UnimplementedError();
  }
}
