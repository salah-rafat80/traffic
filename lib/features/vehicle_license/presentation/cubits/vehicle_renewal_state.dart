import '../../data/models/issue_replacement_response_model.dart';

abstract class VehicleRenewalState {}

class VehicleRenewalInitial extends VehicleRenewalState {}

class VehicleRenewalLoading extends VehicleRenewalState {}

class VehicleRenewalSuccess extends VehicleRenewalState {
  final IssueReplacementResponseModel response;
  VehicleRenewalSuccess(this.response);
}

class VehicleRenewalFailure extends VehicleRenewalState {
  final String message;
  VehicleRenewalFailure(this.message);
}
