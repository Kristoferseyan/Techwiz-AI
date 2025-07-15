import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:techwiz/features/auth/data/models/login_response_model.dart';

final String baseUrl = dotenv.env['API_URL'] ?? "null";

class AuthApiService {
  final http.Client client;
  AuthApiService(this.client);

  Future<LoginResponseModel?> login(String username, String password) async {
    final requestBody = jsonEncode({
      'username': username,
      'password': password,
    });

    print('Sending login request with data: $requestBody');

    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    print('Login response status: ${response.statusCode}');
    print('Login response body: ${response.body}');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return LoginResponseModel.fromJson(json);
    } else {
      return null;
    }
  }

  Future<bool> register(
    String username,
    String password,
    String email,
    List<int> roleId,
  ) async {
    final requestBody = jsonEncode({
      'username': username,
      'password': password,
      'email': email,
      'roleIds': roleId,
    });

    print('Sending registration request with data: $requestBody');

    final response = await client.post(
      Uri.parse('$baseUrl/user/addUser'),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    print('Registration response status: ${response.statusCode}');
    print('Registration response body: ${response.body}');

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
