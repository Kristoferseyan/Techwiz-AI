import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/issue.dart';
import '../domain/entities/paginated_response.dart';

class ProblemsApiService {
  final http.Client httpClient;
  final String baseUrl = dotenv.env['API_URL'] ?? "null";

  ProblemsApiService(this.httpClient);

  Map<String, String> _getHeaders(String? token) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<List<Issue>> getCommonIssues({String? token}) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/problems/paginatedProblems'),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['content'] ?? [];
        return data.map((json) => _issueFromProblemsDto(json)).toList();
      } else {
        throw Exception('Failed to load common issues: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load common issues: $e');
    }
  }

  Future<PaginatedResponse<Issue>> getPaginatedIssues({
    String? token,
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/problems/paginatedProblems?page=$page&size=$size'),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return PaginatedResponse.fromJson(
          responseData,
          (json) => _issueFromProblemsDto(json),
        );
      } else {
        throw Exception(
          'Failed to load paginated issues: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load paginated issues: $e');
    }
  }

  Future<List<Issue>> getIssuesByCategory(
    String category, {
    String? token,
  }) async {
    try {
      print('DEBUG: Fetching issues for category: "$category"');

      if (category == 'All') {
        final response = await httpClient.get(
          Uri.parse('$baseUrl/problems/paginatedProblems'),
          headers: _getHeaders(token),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          final List<dynamic> data = responseData['content'] ?? [];
          return data.map((json) => _issueFromProblemsDto(json)).toList();
        } else {
          throw Exception('Failed to load all issues: ${response.statusCode}');
        }
      }

      final categoryResponse = await httpClient.get(
        Uri.parse('$baseUrl/category'),
        headers: _getHeaders(token),
      );

      print('DEBUG: Category response status: ${categoryResponse.statusCode}');

      if (categoryResponse.statusCode == 200) {
        final List<dynamic> categories = json.decode(categoryResponse.body);
        print('DEBUG: Found ${categories.length} categories');

        final categoryData = categories.firstWhere(
          (cat) => cat['name'] == category,
          orElse: () => null,
        );

        if (categoryData != null && categoryData['problems'] != null) {
          final List<dynamic> problems = categoryData['problems'];
          print(
            'DEBUG: Found ${problems.length} problems for category "$category"',
          );
          return problems.map((json) => _issueFromProblemsDto(json)).toList();
        } else {
          print('DEBUG: Category "$category" not found or has no problems');
          return [];
        }
      } else {
        throw Exception(
          'Failed to load categories: ${categoryResponse.statusCode}',
        );
      }
    } catch (e) {
      print('DEBUG: Error in getIssuesByCategory: $e');
      throw Exception('Failed to load issues by category: $e');
    }
  }

  Issue _issueFromProblemsDto(Map<String, dynamic> json) {
    return Issue(
      id:
          json['id']?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: json['name'] ?? 'Unknown Problem',
      description: json['description'] ?? 'No description available',
      difficulty: 'Medium',
      estimatedTime: '15 min',
      rating: 4.0,
      category: 'General',
      createdAt: DateTime.now(),
    );
  }
}
