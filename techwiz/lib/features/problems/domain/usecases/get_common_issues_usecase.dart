import '../repositories/problems_repository.dart';
import '../entities/issue.dart';

class GetCommonIssuesUseCase {
  final ProblemsRepository repository;

  GetCommonIssuesUseCase(this.repository);

  Future<List<Issue>> call({String? token}) async {
    return await repository.getCommonIssues(token: token);
  }
}
