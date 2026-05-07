import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:traffic/features/violations_inquiry/data/repositories/violations_repository.dart';
import 'violations_state.dart';

@injectable
class ViolationsCubit extends Cubit<ViolationsState> {
  final ViolationsRepository _repository;

  ViolationsCubit(this._repository) : super(ViolationsInitial());

  Future<void> loadDrivingLicenseViolations({
    required String licenseNumber,
  }) async {
    emit(ViolationsLoading());
    final result = await _repository.getDrivingLicenseViolations(
      licenseNumber: licenseNumber,
    );
    if (result.isSuccess && result.data != null) {
      emit(ViolationsLoaded(violationsList: result.data!));
    } else {
      emit(ViolationsFailure(
        message: result.error ?? 'حدث خطأ غير متوقع.',
      ));
    }
  }

  Future<void> loadVehicleLicenseViolations({
    required String licenseNumber,
  }) async {
    emit(ViolationsLoading());
    final result = await _repository.getVehicleLicenseViolations(
      licenseNumber: licenseNumber,
    );
    if (result.isSuccess && result.data != null) {
      emit(ViolationsLoaded(violationsList: result.data!));
    } else {
      emit(ViolationsFailure(
        message: result.error ?? 'حدث خطأ غير متوقع.',
      ));
    }
  }
}
