import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/ai_match_request.dart';
import '../domain/entities/ai_match_response.dart';

class AiApiService {
  final http.Client httpClient;
  final String baseUrl = dotenv.env['API_URL'] ?? "null";

  AiApiService(this.httpClient);

  Map<String, String> _getHeaders(String? token) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<AiMatchResponse> matchProblems(
    AiMatchRequest request, {
    String? token,
  }) async {
    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/ai/match'),
        headers: _getHeaders(token),
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return AiMatchResponse.fromJson(responseData);
      } else {
        throw Exception('Failed to match problems: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to match problems: $e');
    }
  }
}
