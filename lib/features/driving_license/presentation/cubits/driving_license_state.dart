import '../../data/models/driving_license_finalize_model.dart';
import '../../../profile/data/models/profile_model.dart';

abstract class DrivingLicenseState {}

class DrivingLicenseInitial extends DrivingLicenseState {}

class DrivingLicenseLoading extends DrivingLicenseState {}

/// Separate loading state for the finalize step (keeps upload spinner separate).
class DrivingLicenseFinalizeLoading extends DrivingLicenseState {}

/// Success state after document upload. Includes the request number to be passed along.
class DrivingLicenseUploadSuccess extends DrivingLicenseState {
  final String requestNumber;
  DrivingLicenseUploadSuccess({required this.requestNumber});
}

class DrivingLicenseFailure extends DrivingLicenseState {
  final String message;
  DrivingLicenseFailure({required this.message});
}

/// Success state after finalization. Includes full API response (with fees) + profile.
class DrivingLicenseFinalizeSuccess extends DrivingLicenseState {
  final DrivingLicenseFinalizeResponseModel response;
  final ProfileModel profile;

  DrivingLicenseFinalizeSuccess({
    required this.response,
    required this.profile,
  });
}
