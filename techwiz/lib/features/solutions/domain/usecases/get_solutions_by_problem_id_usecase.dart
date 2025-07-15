import '../repositories/solutions_repository.dart';
import '../entities/solution.dart';

class GetSolutionsByProblemIdUseCase {
  final SolutionsRepository repository;

  GetSolutionsByProblemIdUseCase(this.repository);

  Future<List<Solution>> call(int problemId, {String? token}) async {
    return await repository.getSolutionsByProblemId(problemId, token: token);
  }
}
