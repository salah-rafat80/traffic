import '../../data/models/issue_replacement_response_model.dart';

abstract class VehicleReplacementState {}

class VehicleReplacementInitial extends VehicleReplacementState {}

class VehicleReplacementLoading extends VehicleReplacementState {}

class VehicleReplacementSuccess extends VehicleReplacementState {
  final IssueReplacementResponseModel response;

  VehicleReplacementSuccess(this.response);
}

class VehicleReplacementFailure extends VehicleReplacementState {
  final String message;

  VehicleReplacementFailure(this.message);
}
