import '../repositories/search_repository.dart';
import 'package:techwiz/features/problems/domain/entities/issue.dart';

class SearchIssuesUseCase {
  final SearchRepository repository;

  SearchIssuesUseCase(this.repository);

  Future<List<Issue>> call(String query, {String? token}) async {
    return await repository.searchIssues(query, token: token);
  }
}
