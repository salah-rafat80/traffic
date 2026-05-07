import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/driving_license_repository.dart';
import 'driving_replacement_state.dart';

@injectable
class DrivingReplacementCubit extends Cubit<DrivingReplacementState> {
  final DrivingLicenseRepository _repository;

  DrivingReplacementCubit(this._repository) : super(DrivingReplacementInitial());

  Future<void> issueReplacement({
    required String licenseNumber,
    required String replacementType,
    required int method,
    String? governorate,
    String? city,
    String? details,
  }) async {
    emit(DrivingReplacementLoading());

    final result = await _repository.issueReplacement(
      licenseNumber: licenseNumber,
      replacementType: replacementType,
      method: method,
      governorate: governorate,
      city: city,
      details: details,
    );

    if (result.isSuccess && result.data != null) {
      emit(DrivingReplacementSuccess(result.data!));
    } else {
      emit(DrivingReplacementFailure(result.error ?? 'حدث خطأ غير متوقع'));
    }
  }
}
