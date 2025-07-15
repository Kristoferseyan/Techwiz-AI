import '../entities/solution.dart';
import '../entities/solution_step.dart';

abstract class SolutionsRepository {
  Future<List<Solution>> getSolutionsByProblemId(
    int problemId, {
    String? token,
  });

  Future<List<SolutionStep>> getSolutionStepsBySolutionId(
    int solutionId, {
    String? token,
  });
}
