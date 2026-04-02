abstract class DrivingLicenseState {}

class DrivingLicenseInitial extends DrivingLicenseState {}

class DrivingLicenseLoading extends DrivingLicenseState {}

/// Success state after document upload. Includes the request number to be passed along.
class DrivingLicenseUploadSuccess extends DrivingLicenseState {
  final String requestNumber;
  DrivingLicenseUploadSuccess({required this.requestNumber});
}

class DrivingLicenseFailure extends DrivingLicenseState {
  final String message;
  DrivingLicenseFailure({required this.message});
}
