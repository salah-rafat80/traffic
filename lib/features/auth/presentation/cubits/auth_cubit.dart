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

  Future<void> login(String mobileNumber, String password, {String? requiredRole}) async {
    emit(AuthLoading());
    try {
      final (error, roles) = await authRepository.login(mobileNumber, password);
      if (error == null) {
        final rolesList = roles ?? [];
        
        // Validate role if required
        if (requiredRole != null) {
          bool isValid = false;
          if (requiredRole == 'CITIZEN') {
            isValid = rolesList.contains('CITIZEN');
          } else if (requiredRole == 'STAFF') {
            isValid = rolesList.any((r) => ['INSPECTOR', 'DOCTOR', 'EXAMINATOR'].contains(r));
          }

          if (!isValid) {
            await authRepository.logout(); // Clear token/roles if mismatch
            emit(AuthFailure(message: 'عذراً، لا تمتلك الصلاحية للدخول من هذا المسار.'));
            return;
          }
        }

        // Only fetch citizen licenses if user is a CITIZEN
        if (rolesList.contains('CITIZEN')) {
          final result = await drivingLicenseRepository.getMyLicenses();
          if (result.isSuccess) {
            await drivingLicenseRepository.saveLicensesLocal(result.data!);
          }
        }
        emit(AuthLoginSuccess(roles: rolesList));
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
      final roles = await authRepository.getRoles();
      emit(AuthAuthenticated(roles: roles));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    emit(AuthUnauthenticated());
  }
}


