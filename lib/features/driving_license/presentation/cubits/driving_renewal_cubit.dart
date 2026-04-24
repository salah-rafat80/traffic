import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/driving_renewal_model.dart';
import '../../data/repositories/driving_renewal_repository.dart';
import '../../../profile/data/models/profile_model.dart';
import '../../../profile/data/repositories/profile_repository.dart';
import '../../../../core/api/profile_cache.dart';

abstract class DrivingRenewalState {
  const DrivingRenewalState();
}

class DrivingRenewalInitial extends DrivingRenewalState {
  const DrivingRenewalInitial();
}

class DrivingRenewalLoading extends DrivingRenewalState {
  const DrivingRenewalLoading();
}

class DrivingRenewalSuccess extends DrivingRenewalState {
  final RenewalResponseModel response;

  const DrivingRenewalSuccess({required this.response});
}

class DrivingRenewalFailure extends DrivingRenewalState {
  final String message;

  const DrivingRenewalFailure({required this.message});
}

class DrivingRenewalFinalizeLoading extends DrivingRenewalState {
  const DrivingRenewalFinalizeLoading();
}

class DrivingRenewalFinalizeSuccess extends DrivingRenewalState {
  final FinalizeRenewalResponseModel response;
  final ProfileModel profile;

  const DrivingRenewalFinalizeSuccess({
    required this.response,
    required this.profile,
  });
}

class DrivingRenewalCubit extends Cubit<DrivingRenewalState> {
  final DrivingLicenseRenewalDataHandler _dataHandler;
  final ProfileRepository _profileRepository;

  DrivingRenewalCubit({
    required DrivingLicenseRenewalDataHandler dataHandler,
    required ProfileRepository profileRepository,
  })  : _dataHandler = dataHandler,
        _profileRepository = profileRepository,
        super(const DrivingRenewalInitial());

  Future<void> submitRenewalRequestFromUi({
    required bool isTermsAccepted,
    required String selectedLicenseNumber,
    required String? selectedGovernorate,
    required String? selectedTrafficUnit,
    required DateTime? selectedAppointmentDate,
    required String? selectedAppointmentSlot,
  }) async {
    emit(const DrivingRenewalLoading());

    final RenewalUiSnapshot uiSnapshot = RenewalUiSnapshot(
      isTermsAccepted: isTermsAccepted,
      selectedLicenseNumber: selectedLicenseNumber,
      selectedGovernorate: selectedGovernorate,
      selectedTrafficUnit: selectedTrafficUnit,
      selectedAppointmentDate: selectedAppointmentDate,
      selectedAppointmentSlot: selectedAppointmentSlot,
    );

    final result = await _dataHandler.submitRenewalFromUi(
      uiSnapshot: uiSnapshot,
    );

    if (result.isSuccess && result.data != null) {
      emit(DrivingRenewalSuccess(response: result.data!));
      return;
    }

    emit(
      DrivingRenewalFailure(
        message: result.error ?? 'حدث خطأ غير متوقع.',
      ),
    );
  }

  Future<void> finalizeRenewal({
    required String requestNumber,
    required int method,
    String? governorate,
    String? city,
    String? details,
  }) async {
    emit(const DrivingRenewalFinalizeLoading());

    // 1. Finalize the renewal request
    final result = await _dataHandler.finalizeRenewalFromUi(
      requestNumber: requestNumber,
      method: method,
      governorate: governorate,
      city: city,
      details: details,
    );

    if (result.isSuccess && result.data != null) {
      // 2. Fetch user profile data
      final profileResult = await _profileRepository.getProfile();

      if (profileResult.isSuccess && profileResult.data != null) {
        final profile = profileResult.data!;

        // 3. Cache profile locally
        await ProfileCache().saveProfile(profile);

        emit(DrivingRenewalFinalizeSuccess(
          response: result.data!,
          profile: profile,
        ));
        return;
      } else {
        emit(DrivingRenewalFailure(
          message: profileResult.error ?? 'فشل استلام بيانات الملف الشخصي.',
        ));
        return;
      }
    }

    emit(
      DrivingRenewalFailure(
        message: result.error ?? 'حدث خطأ غير متوقع.',
      ),
    );
  }

  void reset() {
    emit(const DrivingRenewalInitial());
  }
}
