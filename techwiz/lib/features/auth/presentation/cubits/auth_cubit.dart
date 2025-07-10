import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techwiz/features/auth/domain/usecases/login_user.dart';
import 'package:techwiz/features/auth/domain/usecases/register_user.dart';
import 'package:techwiz/features/auth/presentation/cubits/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;

  AuthCubit(
    super.initialState, {
    required this.loginUser,
    required this.registerUser,
  });

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      final session = await loginUser(username, password);
      if (session != null) {
        emit(AuthSuccess(session));
      } else {
        emit(AuthFailure("Invalid credentials"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> register(
    String username,
    String email,
    String password,
    List<int> roleIds,
  ) async {
    emit(AuthLoading());
    try {
      final success = await registerUser(username, email, password, roleIds);
      if (success) {
        emit(AuthRegistered());
      } else {
        emit(AuthFailure("Registration failed"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
