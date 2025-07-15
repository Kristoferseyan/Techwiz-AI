import '../repositories/dashboard_repository.dart';
import '../entities/guide.dart';

class GetRecentGuidesUseCase {
  final DashboardRepository repository;

  GetRecentGuidesUseCase(this.repository);

  Future<List<Guide>> call({String? token}) async {
    return await repository.getRecentGuides(token: token);
  }
}
