import 'package:flutter/foundation.dart';
import '../../../driving_license/data/models/issue_replacement_response_model.dart';

@immutable
sealed class DrivingReplacementState {}

class DrivingReplacementInitial extends DrivingReplacementState {}

class DrivingReplacementLoading extends DrivingReplacementState {}

class DrivingReplacementSuccess extends DrivingReplacementState {
  final IssueReplacementResponseModel response;

  DrivingReplacementSuccess(this.response);
}

class DrivingReplacementFailure extends DrivingReplacementState {
  final String errorMessage;

  DrivingReplacementFailure(this.errorMessage);
}
