import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import 'package:traffic/features/driving_license/data/repositories/driving_license_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final DrivingLicenseRepository drivingLicenseRepository;

  AuthCubit({
    required this.authRepository,
    required this.drivingLicenseRepository,
  }) : super(AuthInitial());

  Future<void> login(String mobileNumber, String password) async {
    emit(AuthLoading());
    try {
      final error = await authRepository.login(mobileNumber, password);
      if (error == null) {
        // Fetch and store licenses immediately after successful login
        final result = await drivingLicenseRepository.getMyLicenses();
        if (result.isSuccess) {
          await drivingLicenseRepository.saveLicensesLocal(result.data!);
          emit(AuthLoginSuccess());
        } else {
          // Even if license fetch fails, we logic success because the user is authenticated
          // but we might want to log it or handle it. For now, just continue.
          emit(AuthLoginSuccess());
        }
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
  Future<void> checkAuthStatus() async {
    final hasToken = await authRepository.hasToken();
    if (hasToken) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    emit(AuthUnauthenticated());
  }
}


