import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/driving_license_repository.dart';
import 'driving_license_state.dart';

class DrivingLicenseCubit extends Cubit<DrivingLicenseState> {
  final DrivingLicenseRepository _repository;

  DrivingLicenseCubit(this._repository) : super(DrivingLicenseInitial());

  Future<void> uploadDocuments({
    required String category,
    required String governorate,
    required String licensingUnit,
    required String personalPhotoPath,
    required String idCardPath,
    required String educationalCertificatePath,
    String? residenceProofPath,
  }) async {
    emit(DrivingLicenseLoading());
    final result = await _repository.uploadDocuments(
      category: category,
      governorate: governorate,
      licensingUnit: licensingUnit,
      personalPhotoPath: personalPhotoPath,
      idCardPath: idCardPath,
      educationalCertificatePath: educationalCertificatePath,
      residenceProofPath: residenceProofPath,
    );

    if (result.isSuccess && result.data != null) {
      emit(DrivingLicenseUploadSuccess(requestNumber: result.data!));
    } else {
      emit(DrivingLicenseFailure(message: result.error ?? 'حدث خطأ غير متوقع.'));
    }
  }
}
