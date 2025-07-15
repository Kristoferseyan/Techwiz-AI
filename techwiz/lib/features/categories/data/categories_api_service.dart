import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/category.dart';

class CategoriesApiService {
  final http.Client httpClient;
  final String baseUrl = dotenv.env['API_URL'] ?? "null";

  CategoriesApiService(this.httpClient);

  Map<String, String> _getHeaders(String? token) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
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

  Future<List<Category>> getCategoriesDetailed({String? token}) async {
    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/category'),
        headers: _getHeaders(token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
