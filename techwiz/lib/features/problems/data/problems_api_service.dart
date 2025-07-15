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

      final categoryUrl =
          '$baseUrl/problems/problemsByCategory/${Uri.encodeComponent(category)}';

      final response = await httpClient.get(
        Uri.parse(categoryUrl),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => _issueFromProblemsDto(json)).toList();
      } else {
        throw Exception(
          'Failed to load category "$category": ${response.statusCode}',
        );
      }
    } catch (e) {
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
