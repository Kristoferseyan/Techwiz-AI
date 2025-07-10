import 'package:techwiz/features/auth/domain/entities/UserSession.dart'
    show UserSession;

abstract class AuthRepository {
  Future<UserSession?> login(String username, String password);

  Future<bool> register(
    String username,
    String password,
    String email,
    List<int> roleIds,
  );
}
