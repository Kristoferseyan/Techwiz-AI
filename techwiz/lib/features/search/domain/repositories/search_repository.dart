import 'package:techwiz/features/problems/domain/entities/issue.dart';

abstract class SearchRepository {
  Future<List<Issue>> searchIssues(String query, {String? token});
}
