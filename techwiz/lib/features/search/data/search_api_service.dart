import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:techwiz/features/problems/domain/entities/issue.dart';

class SearchApiService {
  final http.Client httpClient;
  final String baseUrl = dotenv.env['API_URL'] ?? "null";

  SearchApiService(this.httpClient);

  Map<String, String> _getHeaders(String? token) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<List<Issue>> searchIssues(String query, {String? token}) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/problems/paginatedProblems'),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['content'] ?? [];
        final allIssues = data
            .map((json) => _issueFromProblemsDto(json))
            .toList();
        return allIssues.where((issue) {
          final lowerQuery = query.toLowerCase();
          return issue.title.toLowerCase().contains(lowerQuery) ||
              issue.description.toLowerCase().contains(lowerQuery);
        }).toList();
      } else {
        throw Exception('Failed to search issues: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to search issues: $e');
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
