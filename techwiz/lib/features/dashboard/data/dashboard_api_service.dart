import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../domain/entities/quick_action.dart';
import '../domain/entities/guide.dart';

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

  Future<List<Guide>> getRecentGuides({String? token}) async {
    try {
      // TODO: Implement when guides endpoint is available
      return <Guide>[];
    } catch (e) {
      throw Exception('Failed to load recent guides: $e');
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

  String _truncateDescription(String description) {
    if (description.length <= 25) return description;
    return '${description.substring(0, 25)}...';
  }
}
