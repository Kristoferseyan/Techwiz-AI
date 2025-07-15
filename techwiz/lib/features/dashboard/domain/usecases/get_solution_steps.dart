import '../entities/solution_step.dart';
import '../repositories/dashboard_repository.dart';

class GetSolutionSteps {
  final DashboardRepository repository;

  GetSolutionSteps(this.repository);

  Future<List<SolutionStep>> call(int solutionId, {String? token}) async {
    return await repository.getSolutionStepsBySolutionId(
      solutionId,
      token: token,
    );
  }
}
