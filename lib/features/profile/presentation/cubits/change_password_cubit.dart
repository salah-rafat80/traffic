import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/profile_repository.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ProfileRepository _repository;

  ChangePasswordCubit(this._repository) : super(ChangePasswordInitial());

  /// Initiates the password reset by requesting an OTP for the given [email].
  Future<void> requestOTP(String email) async {
    emit(ChangePasswordLoading());
    final result = await _repository.forgotPassword(email);
    
    if (result.isSuccess) {
      emit(ChangePasswordOTPSent(email: email));
    } else {
      emit(ChangePasswordFailure(message: result.error ?? 'فشل إرسال رمز التحقق'));
    }
  }

  /// Confirms the password reset with [code] and [newPassword].
  Future<void> confirmReset({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoading());
    final result = await _repository.resetPassword(
      email: email,
      code: code,
      newPassword: newPassword,
    );
    
    if (result.isSuccess) {
      emit(ChangePasswordSuccess());
    } else {
      emit(ChangePasswordFailure(message: result.error ?? 'فشل تغيير كلمة المرور'));
    }
  }
}
