import 'package:techwiz/features/auth/data/auth_api_service.dart';
import 'package:techwiz/features/auth/domain/entities/UserSession.dart';
import 'package:techwiz/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService api;
  AuthRepositoryImpl(this.api);
  @override
  Future<UserSession?> login(String username, String password) async {
    final response = await api.login(username, password);
    if (response == null) return null;
    return UserSession(
      email: response.email,
      roleIds: response.roles,
      token: response.token,
      username: response.username,
    );
  }

  @override
  Future<bool> register(
    String username,
    String password,
    String email,
    List<int> roleIds,
  ) {
    throw UnimplementedError();
  }
}
