import 'package:techwiz/features/auth/domain/entities/UserSession.dart';
import 'package:techwiz/features/auth/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository authRepository;
  LoginUser(this.authRepository);

  Future<UserSession?> call(String username, String password) {
    return authRepository.login(username, password);
  }
}
