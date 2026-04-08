abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

/// OTP for password reset sent successfully.
class ChangePasswordOTPSent extends ChangePasswordState {
  final String email;
  ChangePasswordOTPSent({required this.email});
}

/// Password reset confirmed successfully.
class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordFailure extends ChangePasswordState {
  final String message;
  ChangePasswordFailure({required this.message});
}
