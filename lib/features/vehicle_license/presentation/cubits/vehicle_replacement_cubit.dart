import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/vehicle_license_repository.dart';
import 'vehicle_replacement_state.dart';

@injectable
class VehicleReplacementCubit extends Cubit<VehicleReplacementState> {
  final VehicleLicenseRepository _repository;

  VehicleReplacementCubit(this._repository) : super(VehicleReplacementInitial());

  Future<void> issueReplacement({
    required String licenseNumber,
    required String replacementType,
    required int method,
    String? governorate,
    String? city,
    String? details,
  }) async {
    emit(VehicleReplacementLoading());

    final result = await _repository.issueReplacement(
      licenseNumber: licenseNumber,
      replacementType: replacementType,
      method: method,
      governorate: governorate,
      city: city,
      details: details,
    );

    if (isClosed) return;

    if (result.isSuccess && result.data != null) {
      emit(VehicleReplacementSuccess(result.data!));
    } else {
      emit(VehicleReplacementFailure(result.error ?? 'حدث خطأ غير متوقع'));
    }
  }
}
