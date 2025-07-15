import '../../domain/repositories/solutions_repository.dart';
import '../../domain/entities/solution.dart';
import '../../domain/entities/solution_step.dart';
import '../solutions_api_service.dart';

class SolutionsRepositoryImpl implements SolutionsRepository {
  final SolutionsApiService apiService;

  SolutionsRepositoryImpl(this.apiService);

  @override
  Future<List<Solution>> getSolutionsByProblemId(
    int problemId, {
    String? token,
  }) async {
    return await apiService.getSolutionsByProblemId(problemId, token: token);
  }

  @override
  Future<List<SolutionStep>> getSolutionStepsBySolutionId(
    int solutionId, {
    String? token,
  }) async {
    return await apiService.getSolutionStepsBySolutionId(
      solutionId,
      token: token,
    );
  }
}
