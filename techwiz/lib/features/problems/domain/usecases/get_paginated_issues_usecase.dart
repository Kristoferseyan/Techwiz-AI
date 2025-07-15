import '../repositories/problems_repository.dart';
import '../entities/issue.dart';
import '../entities/paginated_response.dart';

class GetPaginatedIssuesUseCase {
  final ProblemsRepository repository;

  GetPaginatedIssuesUseCase(this.repository);

  Future<PaginatedResponse<Issue>> call({
    String? token,
    int page = 0,
    int size = 10,
  }) async {
    return await repository.getPaginatedIssues(
      token: token,
      page: page,
      size: size,
    );
  }
}
