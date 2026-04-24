import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/driving_license_repository.dart';
import '../../../profile/data/repositories/profile_repository.dart';
import '../../../../core/api/profile_cache.dart';
import 'driving_license_state.dart';

class DrivingLicenseCubit extends Cubit<DrivingLicenseState> {
  final DrivingLicenseRepository _repository;
  final ProfileRepository _profileRepository;

  DrivingLicenseCubit({
    required DrivingLicenseRepository repository,
    required ProfileRepository profileRepository,
  })  : _repository = repository,
        _profileRepository = profileRepository,
        super(DrivingLicenseInitial());

  Future<void> uploadDocuments({
    required String category,
    required String personalPhotoPath,
    required String idCardPath,
    required String educationalCertificatePath,
    String? residenceProofPath,
    String? medicalCertificatePath,
  }) async {
    emit(DrivingLicenseLoading());
    final result = await _repository.uploadDocuments(
      category: category,
      personalPhotoPath: personalPhotoPath,
      idCardPath: idCardPath,
      educationalCertificatePath: educationalCertificatePath,
      residenceProofPath: residenceProofPath,
      medicalCertificatePath: medicalCertificatePath,
    );

    if (result.isSuccess && result.data != null) {
      emit(DrivingLicenseUploadSuccess(requestNumber: result.data!));
    } else {
      emit(DrivingLicenseFailure(message: result.error ?? 'حدث خطأ غير متوقع.'));
    }
  }

  Future<void> finalizeDrivingLicense({
    required String requestNumber,
    required int method,
    String? governorate,
    String? city,
    String? details,
  }) async {
    emit(DrivingLicenseFinalizeLoading());

    // 1. Call finalize API (returns real fees + status)
    final result = await _repository.finalizeDrivingLicense(
      requestNumber: requestNumber,
      method: method,
      governorate: governorate,
      city: city,
      details: details,
    );

    if (result.isSuccess && result.data != null) {
      // 2. Fetch user profile for applicant details
      final profileResult = await _profileRepository.getProfile();

      if (profileResult.isSuccess && profileResult.data != null) {
        final profile = profileResult.data!;

        // 3. Cache profile locally
        await ProfileCache().saveProfile(profile);

        emit(DrivingLicenseFinalizeSuccess(
          response: result.data!,
          profile: profile,
        ));
        return;
      } else {
        emit(DrivingLicenseFailure(
          message: profileResult.error ?? 'فشل استلام بيانات الملف الشخصي.',
        ));
        return;
      }
    }

    emit(DrivingLicenseFailure(message: result.error ?? 'حدث خطأ غير متوقع.'));
  }
}
