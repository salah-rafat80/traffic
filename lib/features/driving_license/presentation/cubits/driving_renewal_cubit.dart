import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/driving_renewal_model.dart';
import '../../data/repositories/driving_renewal_repository.dart';

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

  const DrivingRenewalFinalizeSuccess({required this.response});
}

class DrivingRenewalCubit extends Cubit<DrivingRenewalState> {
  final DrivingLicenseRenewalDataHandler _dataHandler;

  DrivingRenewalCubit({required DrivingLicenseRenewalDataHandler dataHandler})
      : _dataHandler = dataHandler,
        super(const DrivingRenewalInitial());

  Future<void> submitRenewalRequestFromUi({
    required bool isTermsAccepted,
    required String? selectedGovernorate,
    required String? selectedTrafficUnit,
    required DateTime? selectedAppointmentDate,
    required String? selectedAppointmentSlot,
  }) async {
    emit(const DrivingRenewalLoading());

    final RenewalUiSnapshot uiSnapshot = RenewalUiSnapshot(
      isTermsAccepted: isTermsAccepted,
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

    final result = await _dataHandler.finalizeRenewalFromUi(
      requestNumber: requestNumber,
      method: method,
      governorate: governorate,
      city: city,
      details: details,
    );

    if (result.isSuccess && result.data != null) {
      emit(DrivingRenewalFinalizeSuccess(response: result.data!));
      return;
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
