import 'package:techwiz/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository authRepository;
  RegisterUser(this.authRepository);

  Future<bool> call(
    String username,
    String password,
    String email,
    List<int> roleIds,
  ) {
    return authRepository.register(username, password, email, roleIds);
  }
}
