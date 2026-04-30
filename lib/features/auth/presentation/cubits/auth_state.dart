abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final List<String> roles;
  AuthLoginSuccess({required this.roles});
}

class AuthRegisterSuccess extends AuthState {}

class AuthVerifyOtpSuccess extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {
  final List<String> roles;
  AuthAuthenticated({required this.roles});
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}
