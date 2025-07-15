import '../entities/solution.dart';
import '../repositories/dashboard_repository.dart';

class GetSolutionsByProblemId {
  final DashboardRepository repository;

  GetSolutionsByProblemId(this.repository);

  Future<List<Solution>> call(int problemId, {String? token}) async {
    return await repository.getSolutionsByProblemId(problemId, token: token);
  }
}
