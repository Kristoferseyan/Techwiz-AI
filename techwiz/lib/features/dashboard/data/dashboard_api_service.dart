import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/quick_action.dart';
import '../domain/entities/issue.dart';
import '../domain/entities/guide.dart';
import '../domain/entities/solution.dart';

class DashboardApiService {
  final http.Client httpClient;
  final String baseUrl = dotenv.env['API_URL'] ?? "null";

  DashboardApiService(this.httpClient);

  Map<String, String> _getHeaders(String? token) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<List<QuickAction>> getQuickActions({String? token}) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/problems/featured'),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        return data.asMap().entries.map((entry) {
          final index = entry.key;
          final json = entry.value;
          return _quickActionFromProblemsDto(json, index);
        }).toList();
      } else {
        throw Exception('Failed to load quick actions');
      }
    } catch (e) {
      throw Exception('Failed to load quick actions: $e');
    }
  }

  Future<List<Issue>> getCommonIssues({String? token}) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/problems'),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => _issueFromProblemsDto(json)).toList();
      } else {
        throw Exception('Failed to load common issues: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load common issues: $e');
    }
  }

  Future<List<Guide>> getRecentGuides({String? token}) async {
    try {
      return <Guide>[];
    } catch (e) {
      throw Exception('Failed to load recent guides: $e');
    }
  }

  Future<List<String>> getCategories({String? token}) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/category'),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final categories = jsonList.map<String>((category) {
          return category['name'] as String;
        }).toList();

        return ['All', ...categories];
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      return ['All', 'General', 'Hardware', 'Software', 'Network', 'Security'];
    }
  }

  Future<List<Issue>> searchIssues(String query, {String? token}) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/problems'),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
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

  Future<List<Issue>> getIssuesByCategory(
    String category, {
    String? token,
  }) async {
    try {
      if (category == 'All') {
        final response = await httpClient.get(
          Uri.parse('$baseUrl/problems'),
          headers: _getHeaders(token),
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
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

  Future<List<Solution>> getSolutionsByProblemId(
    int problemId, {
    String? token,
  }) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/solutions/getSolutionsByProblemId/$problemId'),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => _solutionFromDto(json)).toList();
      } else {
        throw Exception('Failed to load solutions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load solutions: $e');
    }
  }

  QuickAction _quickActionFromProblemsDto(
    Map<String, dynamic> json,
    int index,
  ) {
    final icons = ['speed', 'wifi_off', 'volume_off', 'power_off'];
    final colors = ['#2196F3', '#FF9800', '#4CAF50', '#F44336'];

    return QuickAction(
      id: (index + 1).toString(),
      title: json['name'] ?? 'Problem ${index + 1}',
      subtitle: _truncateDescription(json['description'] ?? 'Fix this issue'),
      iconName: icons[index % icons.length],
      colorCode: colors[index % colors.length],
      route: '/problem/${index + 1}',
    );
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

  Solution _solutionFromDto(Map<String, dynamic> json) {
    return Solution(
      title: json['title'] ?? 'Solution',
      description: json['description'] ?? 'No description available',
    );
  }

  String _truncateDescription(String description) {
    if (description.length <= 25) return description;
    return '${description.substring(0, 25)}...';
  }
}
