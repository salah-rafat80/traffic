abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  // In a full implementation, you could pass User data here
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}
