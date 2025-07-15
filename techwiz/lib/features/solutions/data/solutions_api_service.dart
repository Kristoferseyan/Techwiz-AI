import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/solution.dart';
import '../domain/entities/solution_step.dart';

class SolutionsApiService {
  final http.Client httpClient;
  final String baseUrl = dotenv.env['API_URL'] ?? "null";

  SolutionsApiService(this.httpClient);

  Map<String, String> _getHeaders(String? token) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
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

  Future<List<SolutionStep>> getSolutionStepsBySolutionId(
    int solutionId, {
    String? token,
  }) async {
    try {
      final response = await httpClient.get(
        Uri.parse(
          '$baseUrl/solution-steps/getSolutionStepBySolutionId/$solutionId',
        ),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => SolutionStep.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load solution steps: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load solution steps: $e');
    }
  }

  Solution _solutionFromDto(Map<String, dynamic> json) {
    return Solution(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Solution',
      description: json['description'] ?? 'No description available',
    );
  }
}
