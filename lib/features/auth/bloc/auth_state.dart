// login_state.dart
abstract class AuthState {}

class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final String username;

  LoginSuccess(this.username);
}

class LoginFailure extends AuthState {
  final String message;

  LoginFailure(this.message);
}
