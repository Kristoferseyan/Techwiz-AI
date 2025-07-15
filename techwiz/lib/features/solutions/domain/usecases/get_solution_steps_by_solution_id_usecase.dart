import '../repositories/solutions_repository.dart';
import '../entities/solution_step.dart';

class GetSolutionStepsBySolutionIdUseCase {
  final SolutionsRepository repository;

  GetSolutionStepsBySolutionIdUseCase(this.repository);

  Future<List<SolutionStep>> call(int solutionId, {String? token}) async {
    return await repository.getSolutionStepsBySolutionId(
      solutionId,
      token: token,
    );
  }
}
