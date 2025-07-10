import '../../domain/entities/UserSession.dart' show UserSession;

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserSession session;
  AuthSuccess(this.session);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class AuthRegistered extends AuthState {}
