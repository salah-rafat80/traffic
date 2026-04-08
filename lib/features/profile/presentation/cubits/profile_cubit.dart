import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(ProfileInitial());

  /// Loads the authenticated citizen's profile from the API.
  Future<void> loadProfile() async {
    emit(ProfileLoading());
    final result = await _repository.getProfile();
    if (result.isSuccess && result.data != null) {
      emit(ProfileLoadSuccess(profile: result.data!));
    } else {
      emit(ProfileFailure(message: result.error ?? 'حدث خطأ غير متوقع.'));
    }
  }

  /// Step 1: Requests an OTP to be sent to [newEmail].
  Future<void> requestEmailChange({required String newEmail}) async {
    emit(ProfileLoading());
    final result = await _repository.requestEmailChange(newEmail: newEmail);
    if (result.isSuccess) {
      emit(ProfileEmailChangeRequested(newEmail: newEmail));
    } else {
      emit(ProfileFailure(message: result.error ?? 'حدث خطأ غير متوقع.'));
    }
  }

  /// Step 2: Confirms the email change with the OTP [code].
  Future<void> confirmEmailChange({
    required String newEmail,
    required String code,
  }) async {
    emit(ProfileLoading());
    final result = await _repository.confirmEmailChange(
      newEmail: newEmail,
      code: code,
    );
    if (result.isSuccess) {
      emit(ProfileEmailChangeConfirmed());
    } else {
      emit(ProfileFailure(message: result.error ?? 'حدث خطأ غير متوقع.'));
    }
  }
}
