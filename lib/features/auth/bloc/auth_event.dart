// login_event.dart
abstract class AuthEvent {}

class LoginSubmitted extends AuthEvent {
  final String username;
  final String password;

  LoginSubmitted({required this.username, required this.password});
}

class LogoutRequested extends AuthEvent {}
