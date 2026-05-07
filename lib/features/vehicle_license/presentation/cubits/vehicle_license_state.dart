import '../../data/models/vehicle_license_model.dart';
import '../../data/models/vehicle_license_finalize_model.dart';
import '../../data/models/vehicle_type_model.dart';
import '../../../profile/data/models/profile_model.dart';

abstract class VehicleLicenseState {}

class VehicleLicenseInitial extends VehicleLicenseState {}

class VehicleLicenseLoading extends VehicleLicenseState {}

class VehicleLicenseInitDataSuccess extends VehicleLicenseState {
  final List<VehicleTypeModel> vehicleTypes;

  VehicleLicenseInitDataSuccess({required this.vehicleTypes});
}

class VehicleLicenseUploadSuccess extends VehicleLicenseState {
  final String requestNumber;
  VehicleLicenseUploadSuccess({required this.requestNumber});
}

class VehicleLicenseFinalizeSuccess extends VehicleLicenseState {
  final VehicleLicenseFinalizeResponseModel response;
  final ProfileModel profile;

  VehicleLicenseFinalizeSuccess({
    required this.response,
    required this.profile,
  });
}

class VehicleLicenseLoadLicensesSuccess extends VehicleLicenseState {
  final List<VehicleLicenseModel> licenses;
  final bool isCached;

  VehicleLicenseLoadLicensesSuccess({required this.licenses, this.isCached = false});
}

class VehicleLicenseInsuranceLoading extends VehicleLicenseState {}

class VehicleLicenseInsuranceLoaded extends VehicleLicenseState {
  final List<InsuranceCompanyModel> companies;
  VehicleLicenseInsuranceLoaded({required this.companies});
}

class VehicleLicenseFailure extends VehicleLicenseState {
  final String message;
  VehicleLicenseFailure({required this.message});
}
