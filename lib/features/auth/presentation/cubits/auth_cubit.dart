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
}
