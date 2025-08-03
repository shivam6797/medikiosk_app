import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medikiosk_app/features/auth/bloc/auth_event.dart';
import 'package:medikiosk_app/features/auth/bloc/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLogin);
    on<LogoutRequested>(_onLogout);
  }

  Future<void> _onLogin(LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(LoginLoading());

    // Hardcoded auth check
    if (event.username == 'admin' && event.password == '1234') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', event.username);

      emit(LoginSuccess(event.username));
    } else {
      emit(LoginFailure('Invalid credentials'));
    }
  }

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    emit(LoginInitial());
  }
}
