import '../../domain/repositories/search_repository.dart';
import 'package:techwiz/features/problems/domain/entities/issue.dart';
import '../search_api_service.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchApiService apiService;

  SearchRepositoryImpl(this.apiService);

  @override
  Future<List<Issue>> searchIssues(String query, {String? token}) async {
    return await apiService.searchIssues(query, token: token);
  }
}
