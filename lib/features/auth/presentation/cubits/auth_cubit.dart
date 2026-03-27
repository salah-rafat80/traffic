import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> login(String mobileNumber, String password) async {
    emit(AuthLoading());
    try {
      final error = await authRepository.login(mobileNumber, password);
      if (error == null) {
        emit(AuthLoginSuccess());
      } else {
        emit(AuthFailure(message: error));
      }
    } catch (e) {
      emit(AuthFailure(message: 'حدث خطأ غير متوقع.'));
    }
  }

  Future<void> register({
    required String nationalId,
    required String mobileNumber,
    required String firstName,
    required String lastName,
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    emit(AuthLoading());
    try {
      final error = await authRepository.register(
        nationalId: nationalId,
        mobileNumber: mobileNumber,
        firstName: firstName,
        lastName: lastName,
        email: email,
        username: username,
        password: password,
        confirmPassword: confirmPassword,
      );
      if (error == null) {
        emit(AuthRegisterSuccess());
      } else {
        emit(AuthFailure(message: error));
      }
    } catch (e) {
      emit(AuthFailure(message: 'حدث خطأ غير متوقع.'));
    }
  }

  Future<void> verifyOtp(String email, String code) async {
    emit(AuthLoading());
    try {
      final error = await authRepository.verifyOtp(email, code);
      if (error == null) {
        emit(AuthVerifyOtpSuccess());
      } else {
        emit(AuthFailure(message: error));
      }
    } catch (e) {
      emit(AuthFailure(message: 'حدث خطأ غير متوقع.'));
    }
  }
}

