import '../repositories/problems_repository.dart';
import '../entities/issue.dart';

class GetIssuesByCategoryUseCase {
  final ProblemsRepository repository;

  GetIssuesByCategoryUseCase(this.repository);

  Future<List<Issue>> call(String category, {String? token}) async {
    return await repository.getIssuesByCategory(category, token: token);
  }
}
