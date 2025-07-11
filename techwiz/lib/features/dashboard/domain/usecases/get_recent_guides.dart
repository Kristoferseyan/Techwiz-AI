import '../entities/guide.dart';
import '../repositories/dashboard_repository.dart';

class GetRecentGuides {
  final DashboardRepository repository;

  GetRecentGuides(this.repository);

  Future<List<Guide>> call({String? token}) async {
    return await repository.getRecentGuides(token: token);
  }
}
